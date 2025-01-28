part of 'search_cubit.dart';

class SearchState extends Equatable {
  final RequestState requestState;
  final String message;
  final bool showSearchResult;
  final List<ProductModel> products;

  const SearchState({
    required this.requestState,
    required this.message,
    required this.showSearchResult,
    required this.products,
  });
  factory SearchState.init() {
    return const SearchState(
      requestState: RequestState.none,
      message: '',
      showSearchResult: false,
      products: [],
    );
  }
  SearchState copyWith({
    RequestState? requestState,
    String? message,
    bool? showSearchResult,
    List<ProductModel>? products,
  }) {
    return SearchState(
      requestState: requestState ?? this.requestState,
      message: message ?? this.message,
      showSearchResult: showSearchResult ?? this.showSearchResult,
      products: products ?? this.products,
    );
  }

  @override
  List<Object> get props => [
        requestState,
        message,
        showSearchResult,
        products,
      ];
}
