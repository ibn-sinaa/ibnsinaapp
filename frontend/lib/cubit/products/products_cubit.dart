import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utils/enums.dart';
import '../../data/models/product/product_model.dart';
import '../../data/params/search_params.dart';
import '../../data/repositories/products_repository.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsRepository _productsRepository;

  ProductsCubit(this._productsRepository) : super(ProductsState.init());

  int _page = 1;
  int _lastPage = 1;
  int _currentSubcategoryId = 0;
  int get currentSubcategoryId => _currentSubcategoryId;

  getSubCategoryProducts([int? id]) async {
    _page = 1;
    if (id != null) {
      _currentSubcategoryId = id;
    }
    emit(state.copyWith(
      subCategoryRequest: RequestState.loading,
      productsRequest: RequestState.none,
    ));
    final responseEither = await _productsRepository.searchForProducts(
      SearchParams(id: _currentSubcategoryId, page: _page),
    );
    responseEither.fold(
      (failure) {
        emit(state.copyWith(
          subCategoryRequest: RequestState.error,
          message: failure.message,
        ));
      },
      (response) {
        _page++;
        _lastPage = response.paginate!.lastPage;
        emit(state.copyWith(
          subCategoryRequest: RequestState.loaded,
          products: response.data,
        ));
      },
    );
  }

  loadMoreProducts() async {
    if (_page > _lastPage || state.productsRequest == RequestState.loading) {
      return;
    }
    emit(state.copyWith(productsRequest: RequestState.loading));
    final responseEither = await _productsRepository.searchForProducts(
      SearchParams(id: _currentSubcategoryId, page: _page),
    );
    responseEither.fold(
      (failure) {
        emit(state.copyWith(
          productsRequest: RequestState.error,
          message: failure.message,
        ));
      },
      (response) {
        _page++;
        final products = state.products;
        products.addAll(response.data);
        emit(state.copyWith(
          productsRequest: RequestState.loaded,
          products: products,
        ));
      },
    );
  }

  resetState() {
    emit(ProductsState.init());
  }
}
