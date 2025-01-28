import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/failures/app_failure.dart';
import '../../data/models/category/category_model.dart';
import '../../data/models/home_model.dart';
import '../../data/models/slider_model.dart';
import '../../data/repositories/products_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ProductsRepository _productsRepository;

  HomeCubit(this._productsRepository) : super(HomeInitial());

  List<SliderModel> _sliders = [];
  List<CategoryModel> _categories = [];
  List<HomeModel> _homeData = [];

  getHomeData({bool refresh = false}) async {
    emit(HomeLoading());
    try {
      if (_sliders.isEmpty || refresh) {
        await _getHomeSliders();
      }
      if (_categories.isEmpty || refresh) {
        await _getCategories();
      }
      await _getHomeData();
      emit(HomeLoaded(
        sliders: _sliders,
        categories: _categories,
        homeData: _homeData,
      ));
    } on AppFailure catch (error) {
      emit(HomeError(error.message));
    }
  }

  Future _getHomeSliders() async {
    final responseEither = await _productsRepository.getHomeSliders();
    responseEither.fold(
      (error) {
        throw error;
      },
      (response) {
        _sliders = response.data;
      },
    );
  }

  Future _getCategories() async {
    final responseEither = await _productsRepository.getCategories();
    responseEither.fold(
      (error) {
        throw error;
      },
      (response) {
        _categories = response.data;
      },
    );
  }

  Future _getHomeData() async {
    final responseEither = await _productsRepository.getHomeData();
    responseEither.fold(
      (error) {
        throw error;
      },
      (response) {
        _homeData = response.data;
      },
    );
  }
}
