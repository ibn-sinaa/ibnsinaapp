import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ibn_sina/core/failures/app_failure.dart';
import 'package:ibn_sina/core/utils/enums.dart';
import 'package:ibn_sina/data/models/option_data/option_data_model.dart';
import 'package:ibn_sina/data/models/option_model/option_model.dart';
import 'package:ibn_sina/data/repositories/orders_repository.dart';
import 'package:pdf_render/pdf_render.dart';

part 'paper_printing_state.dart';

class PaperPrintingCubit extends Cubit<PaperPrintingState> {
  PaperPrintingCubit(this._ordersRepository)
      : super(PaperPrintingState.initial());

  final OrdersRepository _ordersRepository;

  void getInitialData() async {
    emit(state.copyWith(requestState: RequestState.loading));
    try {
      final printingColors = await _getPaperColors();
      final options = await getPaperOptions();

      emit(
        state.copyWith(
          requestState: RequestState.loaded,
          printingColors: printingColors,
          printingColor: printingColors.first,
          options: options,
        ),
      );
    } on AppFailure catch (failure) {
      emit(state.copyWith(
        requestState: RequestState.error,
        message: failure.message,
      ));
    }
  }

  Future<List<OptionDataModel>> _getPaperColors() async {
    final result = await _ordersRepository.getPaperColors();
    return result.fold(
      (failure) => throw failure,
      (response) => response.data,
    );
  }

  Future<List<OptionModel>> getPaperOptions() async {
    final result = await _ordersRepository.getPaperOptions();
    return result.fold(
      (failure) => throw failure,
      (response) => response.data,
    );
  }

  void uploadFile(File file) async {
    final doc = await PdfDocument.openFile(file.path);
    _resetOptions();

    emit(state.copyWith(
      file: file,
      pageCount: doc.pageCount,
      copiesCount: 1,
      printingColor: state.printingColors.first,
      totalPrice: doc.pageCount * state.printingColor!.price,
      optionsPrice: 0,
    ));
  }

  void _resetOptions() {
    if (state.file != null) {
      final options = [...state.options];
      for (var option in options) {
        for (var optionData in option.data) {
          optionData.isSelected = false;
        }
      }
    }
  }

  void changePrintingColor(OptionDataModel printingColor) {
    if (state.printingColor != printingColor) {
      emit(state.copyWith(
        printingColor: printingColor,
        totalPrice: state.pageCount * printingColor.price * state.copiesCount,
      ));
    }
  }

  void changeCopiesCount(int copiesCount) {
    final optionPriceForOneCopy = state.optionsPrice / state.copiesCount;
    for (var option in state.options) {
      for (var optionData in option.data) {
        if (optionData.isSelected) {
          optionData.totalPrice = _calculateOptionPrice(
            byCopy: option.byCopy,
            price: optionData.price,
            copiesCount: copiesCount,
          );
        }
      }
    }

    emit(state.copyWith(
      copiesCount: copiesCount,
      totalPrice: state.pageCount * state.printingColor!.price * copiesCount,
      optionsPrice: optionPriceForOneCopy * copiesCount,
    ));
  }

  void updateOptions(OptionModel option, OptionDataModel optionData) {
    if (optionData.isSelected) {
      _removeOption(option, optionData);
    } else {
      if (option.type == 'radio') {
        _addRadioOption(option, optionData);
      } else {
        _addCheckBoxOption(option, optionData);
      }
    }
  }

  void _addCheckBoxOption(OptionModel option, OptionDataModel optionData) {
    optionData.isSelected = true;
    final addedPrice = _calculateOptionPrice(
      byCopy: option.byCopy,
      price: optionData.price,
    );
    optionData.totalPrice = addedPrice;
    emit(
      state.copyWith(
        optionsPrice: state.optionsPrice + addedPrice,
        refreshData: !state.refreshData,
      ),
    );
  }

  void _removeOption(OptionModel option, OptionDataModel optionData) {
    optionData.isSelected = false;
    final removedPrice = optionData.totalPrice;
    optionData.totalPrice = 0;
    emit(
      state.copyWith(
        optionsPrice: state.optionsPrice - removedPrice,
        refreshData: !state.refreshData,
      ),
    );
  }

  void _addRadioOption(OptionModel option, OptionDataModel optionData) {
    num removedPrice = 0;

    for (var opt in option.data) {
      if (opt.isSelected) {
        removedPrice = opt.totalPrice;
        opt.totalPrice = 0;
      }
      opt.isSelected = false;
    }
    optionData.isSelected = true;

    final addedPrice = _calculateOptionPrice(
      byCopy: option.byCopy,
      price: optionData.price,
    );
    optionData.totalPrice = addedPrice;
    emit(
      state.copyWith(
        optionsPrice: state.optionsPrice + addedPrice - removedPrice,
        refreshData: !state.refreshData,
      ),
    );
  }

  num _calculateOptionPrice({
    required int byCopy,
    required num price,
    int? copiesCount,
  }) {
    num total = 0;

    final cCount = copiesCount ?? state.copiesCount;

    if (byCopy == 0) {
      total = cCount * price;
    } else {
      total = cCount * state.pageCount * price;
    }
    return total;
  }
}
