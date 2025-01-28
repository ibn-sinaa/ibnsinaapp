import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibn_sina/data/repositories/user_repository.dart';
import 'package:collection/collection.dart';
import '../../data/models/product/product_model.dart';

class FavoriteCubit extends Cubit<List<ProductModel>> {
  final UserRepository _userRepository;

  FavoriteCubit(this._userRepository) : super([]);

  addToFavorite(ProductModel productModel) async {
    final products = [...state];
    products.add(productModel);
    _userRepository.addToFavorite(productModel);

    emit(products);
  }

  getFavoriteData() async {
    emit(await _userRepository.getFavoriteData());
  }

  deleteFromFavorite(int id) async {
    final products = [...state];
    final removedProduct = products.firstWhere((product) => product.id == id);
    products.remove(removedProduct);
    await _userRepository.deleteFromFavoriteBy(id);

    emit(products);
  }

  bool isFavorited(int id) {
    return [...state].firstWhereOrNull((product) => product.id == id) != null;
  }
}
