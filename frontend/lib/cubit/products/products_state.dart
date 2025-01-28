part of 'products_cubit.dart';

class ProductsState extends Equatable {
  final RequestState subCategoryRequest;
  final RequestState productsRequest;
  final String message;
  final List<ProductModel> products;

  const ProductsState({
    required this.subCategoryRequest,
    required this.productsRequest,
    required this.message,
    required this.products,
  });

  factory ProductsState.init() {
    return const ProductsState(
      subCategoryRequest: RequestState.none,
      productsRequest: RequestState.none,
      message: '',
      products: [],
    );
  }

  ProductsState copyWith({
    RequestState? subCategoryRequest,
    RequestState? productsRequest,
    String? message,
    List<ProductModel>? products,
  }) {
    return ProductsState(
      subCategoryRequest: subCategoryRequest ?? this.subCategoryRequest,
      productsRequest: productsRequest ?? this.productsRequest,
      message: message ?? this.message,
      products: products ?? this.products,
    );
  }

  @override
  List<Object> get props => [
        subCategoryRequest,
        productsRequest,
        message,
        products,
      ];
}
