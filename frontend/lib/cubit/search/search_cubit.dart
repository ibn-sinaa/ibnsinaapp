import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/enums.dart';
import '../../data/models/product/product_model.dart';
import '../../data/params/search_params.dart';
import '../../data/repositories/products_repository.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final int? categoryId;
  final ProductsRepository _productsRepository;

  SearchCubit(
    this._productsRepository, [
    this.categoryId,
  ]) : super(SearchState.init());

  String _query = '';

  closeSearching() {
    emit(state.copyWith(
      showSearchResult: false,
      requestState: RequestState.none,
    ));
  }

  searchForProduct([String? query]) async {
    if (query != null) {
      _query = query;
    }
    if (_query.isEmpty) {
      emit(
        state.copyWith(
          showSearchResult: false,
          products: [],
          requestState: RequestState.none,
        ),
      );
    } else {
      emit(
        state.copyWith(
          showSearchResult: true,
          requestState: RequestState.loading,
          products: [],
        ),
      );
      final responseEither =
          await _productsRepository.searchForProducts(SearchParams(
        page: 1,
        query: _query,
        id: categoryId,
      ));
      responseEither.fold(
        (failure) {
          emit(state.copyWith(
            requestState: RequestState.error,
            message: failure.message,
          ));
        },
        (response) {
          emit(state.copyWith(
            requestState: RequestState.loaded,
            products: response.data,
          ));
        },
      );
    }
  }
}
