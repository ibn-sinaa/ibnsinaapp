import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ibn_sina/core/utils/enums.dart';
import 'package:ibn_sina/data/models/media_form_model.dart';
import 'package:ibn_sina/data/models/option_data/option_data_model.dart';
import 'package:ibn_sina/data/models/option_model/option_model.dart';
import 'package:ibn_sina/data/repositories/orders_repository.dart';

part 'media_printing_state.dart';

class MediaPrintingCubit extends Cubit<MediaPrintingState> {
  MediaPrintingCubit(this._ordersRepository)
      : super(MediaPrintingState.initial());

  final OrdersRepository _ordersRepository;

  void getInitialData() async {
    emit(state.copyWith(requestState: RequestState.loading));
    final result = await _ordersRepository.getMediaMaterials();
    result.fold(
      (failure) {
        emit(state.copyWith(
            requestState: RequestState.error, message: failure.message));
      },
      (response) {
        final materialOption =
            OptionModel.generateMaterialOption(response.data);
        emit(state.copyWith(
          requestState: RequestState.loaded,
          materialOption: materialOption,
        ));
      },
    );
  }

  Future<void> generateForms(List<File> files) async {
    final forms = [...state.forms];
    for (var file in files) {
      forms.add(MediaFormModel.generateForm(file));
    }
    if (forms.length > 1 && forms.first.file == null) {
      forms.removeAt(0);
    }
    emit(state.copyWith(
      forms: forms,
      totalPrice: _calculateTotalPrice(forms),
    ));
  }

  void changeFile(MediaFormModel form, File file) async {
    form.resetData(file);

    emit(state.copyWith(
      totalPrice: _calculateTotalPrice(),
      refreshData: !state.refreshData,
    ));
  }

  void changeMaterialType(
    MediaFormModel form,
    OptionDataModel materialType,
  ) async {
    form.materialType = materialType;
    emit(state.copyWith(
      totalPrice: _calculateTotalPrice(),
      refreshData: !state.refreshData,
    ));
  }

  void changePaperWidth(MediaFormModel form, int width) {
    form.width = width;
    emit(state.copyWith(
      totalPrice: _calculateTotalPrice(),
    ));
  }

  void changePaperHeight(MediaFormModel form, int height) {
    form.height = height;
    emit(state.copyWith(
      totalPrice: _calculateTotalPrice(),
    ));
  }

  void changeCopiesCount(MediaFormModel form, int copiesCount) {
    form.copiesCount = copiesCount;
    emit(state.copyWith(
      totalPrice: _calculateTotalPrice(),
    ));
  }

  num _calculateTotalPrice([List<MediaFormModel>? forms]) {
    final allForms = forms ?? state.forms;
    return allForms.fold(
      0,
      (previousValue, form) => previousValue + _formPrice(form),
    );
  }

  num _formPrice(MediaFormModel form) {
    return form.width *
        form.height *
        form.copiesCount *
        (form.materialType?.price ?? 0);
  }

  void deleteForm(MediaFormModel form) {
    final forms = [...state.forms];
    forms.remove(form);
    form.controller.dispose();
    emit(state.copyWith(
      forms: forms,
      totalPrice: _calculateTotalPrice(forms),
    ));
  }

  bool isValid() {
    bool isValid = true;
    for (final form in state.forms) {
      if (!form.isValid()) {
        isValid = false;
        break;
      }
    }
    return isValid;
  }

  @override
  Future<void> close() {
    for (var form in state.forms) {
      form.controller.dispose();
    }
    return super.close();
  }
}
