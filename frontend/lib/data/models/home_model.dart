import 'package:ibn_sina/data/models/category/category_model.dart';
import 'package:ibn_sina/data/models/product/product_model.dart';

class HomeModel {
  final CategoryModel category;
  final List<ProductModel> products;

  HomeModel({
    required this.category,
    required this.products,
  });

  factory HomeModel.fromMap(Map<String, dynamic> map) {
    return HomeModel(
      category: CategoryModel.fromMap(map['category']),
      products: map['products'] == null
          ? []
          : (map['products'] as List)
              .map((product) => ProductModel.fromMap(product))
              .toList(),
    );
  }
}
