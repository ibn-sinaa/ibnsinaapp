import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/slider_model.dart';
import '../../data/repositories/products_repository.dart';

part 'home_slider_state.dart';

class HomeSliderCubit extends Cubit<HomeSliderState> {
  final ProductsRepository _productsRepository;

  HomeSliderCubit(this._productsRepository) : super(HomeSliderInitial());

  getHomeSliders() async {
    emit(HomeSliderLoading());
    final responseEither = await _productsRepository.getHomeSliders();
    responseEither.fold(
      (failure) {
        emit(HomeSliderError(failure.message, failure.statusCode));
      },
      (response) {
        emit(HomeSliderLoaded(response.data));
      },
    );
  }
}
