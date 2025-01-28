import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/product_details_model.dart';
import '../../data/repositories/products_repository.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final int productId;
  final ProductsRepository _productsRepository;

  ProductDetailsCubit(
    this.productId,
    this._productsRepository,
  ) : super(ProductDetailsInitial());

  getProductDetails() async {
    emit(ProductDetailsLoading());
    final responseEither =
        await _productsRepository.getProductDetails(productId);
    responseEither.fold(
      (failure) {
        emit(ProductDetailsError(failure.message));
      },
      (response) {
        emit(ProductDetailsLoaded(response.data));
      },
    );
  }
}
