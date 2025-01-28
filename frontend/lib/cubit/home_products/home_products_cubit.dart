import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/home_model.dart';
import '../../data/repositories/products_repository.dart';

part 'home_products_state.dart';

class HomeProductsCubit extends Cubit<HomeProductsState> {
  final ProductsRepository _productsRepository;

  HomeProductsCubit(this._productsRepository) : super(HomeProductsInitial());

  getHomeData() async {
    emit(HomeProductsLoading());
    final responseEither = await _productsRepository.getHomeData();
    responseEither.fold(
      (failure) {
        emit(HomeProductsError(failure.message));
      },
      (response) {
        emit(HomeProductsLoaded(response.data));
      },
    );
  }

  resetState() {
    emit(HomeProductsInitial());
  }
}
