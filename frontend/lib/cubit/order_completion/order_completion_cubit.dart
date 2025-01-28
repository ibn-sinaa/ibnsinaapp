import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:ibn_sina/core/services/service_locator.dart';
import 'package:ibn_sina/core/shared/shared_data.dart';
import 'package:ibn_sina/core/utils/app_strings.dart';
import 'package:ibn_sina/core/utils/enums.dart';
import 'package:ibn_sina/cubit/paper_printing/paper_printing_cubit.dart';
import 'package:ibn_sina/data/models/branch_model.dart';
import 'package:ibn_sina/data/models/cart/cart_model.dart';
import 'package:ibn_sina/data/models/city_model.dart';
import 'package:ibn_sina/data/models/location_model.dart';
import 'package:ibn_sina/data/models/media_form_model.dart';
import 'package:ibn_sina/data/models/option_model/option_model.dart';
import 'package:ibn_sina/data/params/make_media_order_params.dart';
import 'package:ibn_sina/data/params/make_paper_order_params.dart';
import 'package:ibn_sina/data/params/make_product_order_params.dart';
import 'package:ibn_sina/data/repositories/app_repository.dart';
import 'package:ibn_sina/data/repositories/orders_repository.dart';
import 'package:ibn_sina/data/repositories/user_repository.dart';

part 'order_completion_state.dart';

class OrderCompletionCubit extends Cubit<OrderCompletionState> {
  OrderCompletionCubit(
    this._appRepository,
    this._ordersRepository,
    this._userRepository,
  ) : super(OrderCompletionState.initial());

  final AppRepository _appRepository;
  final OrdersRepository _ordersRepository;
  final UserRepository _userRepository;

  Future<void> getAppSettings() async {
    if (locator<SharedData>().tax == null) {
      emit(state.copyWith(requestState: RequestState.loading));
      final result = await _appRepository.getAppSettings();
      result.fold(
        (failure) => emit(
          state.copyWith(
              requestState: RequestState.error, message: failure.message),
        ),
        (_) => emit(
          state.copyWith(requestState: RequestState.loaded),
        ),
      );
    } else {
      emit(
        state.copyWith(requestState: RequestState.loaded),
      );
    }
  }

  changeDeliveryType(DeliveryType deliveryType) {
    emit(state.copyWith(
      deliveryType: deliveryType,
      makeOrderState: RequestState.none,
    ));
  }

  updateBranch(BranchModel? branch) {
    emit(state.copyWith(
      branch: branch,
      makeOrderState: RequestState.none,
    ));
  }

  updateCity(CityModel? city) {
    emit(state.copyWith(
      city: city,
      makeOrderState: RequestState.none,
    ));
  }

  void onLocationUpdated(LocationModel location) {
    emit(state.copyWith(
      location: location,
      makeOrderState: RequestState.none,
    ));
  }

  Future<void> makePaperOrder(PaperPrintingState paperState) async {
    if (!_isDataValidated()) {
      return;
    }
    emit(state.copyWith(
      makeOrderState: RequestState.loading,
    ));

    final params = MakePaperOrderParams(
      paperOrderColorId: paperState.printingColor!.id,
      paperOptionData: _getSelectedOptionsDataIds(paperState.options),
      copyNumbers: paperState.copiesCount,
      pageNumbers: paperState.pageCount,
      userId: _userRepository.getUserData().id,
      deliveryType: state.deliveryType.key,
      branchId: state.branch?.id,
      cityId: state.city?.id,
      latitude: state.location.latLng?.latitude,
      longitude: state.location.latLng?.longitude,
      address: state.location.address,
      street: state.location.buildingNumber,
      floorNumber: state.location.floorNumber,
      flatNumber: state.location.apartmentNumber,
      fileUploaded: paperState.file!.path,
    );
    final responseEither = await _ordersRepository.makePaperOrder(params);
    responseEither.fold(
      (failure) {
        emit(state.copyWith(
          makeOrderState: RequestState.error,
          errorType: 1,
          message: failure.message,
        ));
      },
      (response) {
        emit(state.copyWith(
          makeOrderState: RequestState.loaded,
          message: response.message,
          invoiceUrl: response.payment!.invoiceURL,
        ));
      },
    );
  }

  Future<void> makeMediaOrder(List<MediaFormModel> forms) async {
    if (!_isDataValidated()) {
      return;
    }
    emit(state.copyWith(
      makeOrderState: RequestState.loading,
    ));

    final params = MakeMediaOrderParams(
      userId: _userRepository.getUserData().id,
      deliveryType: state.deliveryType.key,
      branchId: state.branch?.id,
      cityId: state.city?.id,
      latitude: state.location.latLng?.latitude,
      longitude: state.location.latLng?.longitude,
      address: state.location.address,
      street: state.location.buildingNumber,
      floorNumber: state.location.floorNumber,
      flatNumber: state.location.apartmentNumber,
      forms: forms,
    );
    final responseEither = await _ordersRepository.makeMediaOrder(params);
    responseEither.fold(
      (failure) {
        emit(state.copyWith(
          makeOrderState: RequestState.error,
          errorType: 1,
          message: failure.message,
        ));
      },
      (response) {
        emit(state.copyWith(
          makeOrderState: RequestState.loaded,
          message: response.message,
          invoiceUrl: response.payment!.invoiceURL,
        ));
      },
    );
  }

  Future<void> makeProductOrder({
    required List<CartModel> cartItems,
    required int? couponId,
  }) async {
    if (!_isDataValidated()) {
      return;
    }
    emit(state.copyWith(
      makeOrderState: RequestState.loading,
    ));

    final params = MakeProductOrderParams(
      userId: _userRepository.getUserData().id,
      deliveryType: state.deliveryType.key,
      branchId: state.branch?.id,
      cityId: state.city?.id,
      latitude: state.location.latLng?.latitude,
      longitude: state.location.latLng?.longitude,
      address: state.location.address,
      street: state.location.buildingNumber,
      floorNumber: state.location.floorNumber,
      flatNumber: state.location.apartmentNumber,
      couponId: couponId,
      cartItems: cartItems,
    );
    final responseEither = await _ordersRepository.makeProductOrder(params);
    responseEither.fold(
      (failure) {
        emit(state.copyWith(
          makeOrderState: RequestState.error,
          errorType: 1,
          message: failure.message,
        ));
      },
      (response) {
        emit(state.copyWith(
          makeOrderState: RequestState.loaded,
          message: response.message,
          invoiceUrl: response.payment!.invoiceURL,
        ));
      },
    );
  }

  bool _isDataValidated() {
    if (state.deliveryType == DeliveryType.branch) {
      if (state.branch == null) {
        emit(
          state.copyWith(
            refreshData: !state.refreshData,
            errorType: 0,
            makeOrderState: RequestState.error,
            message: AppStrings.pleaseSelectBranch.tr(),
          ),
        );
        return false;
      }
    } else {
      if (state.city == null) {
        emit(
          state.copyWith(
            refreshData: !state.refreshData,
            errorType: 0,
            makeOrderState: RequestState.error,
            message: AppStrings.pleaseSelectCity.tr(),
          ),
        );
        return false;
      } else if (state.location.isLocationSelected() == false) {
        emit(
          state.copyWith(
            refreshData: !state.refreshData,
            errorType: 0,
            makeOrderState: RequestState.error,
            message: AppStrings.pleaseSelectLocation.tr(),
          ),
        );
        return false;
      }
    }
    return true;
  }

  List<int> _getSelectedOptionsDataIds(List<OptionModel> options) {
    final ids = <int>[];
    for (var option in options) {
      final selectedOptionsData = option.data
          .where((optionData) => optionData.isSelected)
          .toList()
          .map((opt) => opt.id)
          .toList();
      ids.addAll(selectedOptionsData);
    }
    return ids;
  }
}
