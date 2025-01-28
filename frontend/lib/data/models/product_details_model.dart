import 'option_model/option_model.dart';
import 'product/product_model.dart';

class ProductDetailsModel {
  final ProductModel productModel;
  final List<OptionModel> options;

  ProductDetailsModel(this.productModel, this.options);
}
