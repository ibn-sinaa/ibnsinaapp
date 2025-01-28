import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/helpers/helper_functions.dart';
import '../../../core/utils/app_constants.dart';
import '../../models/cart/cart_model.dart';
import '../../models/product/product_model.dart';
import '../../models/user_model.dart';

class UserLocalDataSource {
  final GetStorage _storage;

  UserLocalDataSource(this._storage);

  saveUserData(UserModel userModel) {
    _storage.write(AppConstants.user, userModel.toJson());
  }

  UserModel getUserData() {
    return UserModel.fromJson(_storage.read(AppConstants.user));
  }

  clearUserData() {
    return _storage.remove(AppConstants.user);
  }

  saveUserAuthenticatedStatus(bool status) {
    _storage.write(AppConstants.isAuthenticated, status);
  }

  bool isUserAuthenticated() {
    return _storage.read(AppConstants.isAuthenticated) ?? false;
  }

  saveGuestUser(bool isGuest) {
    _storage.write(AppConstants.isGuest, isGuest);
  }

  bool isGuest() {
    return _storage.read(AppConstants.isGuest) ?? false;
  }

  saveFirstTimeStatus() {
    _storage.write(AppConstants.firstTime, '');
  }

  bool isFirstTime() {
    return _storage.read(AppConstants.firstTime) == null;
  }

  /* ****************** Notifications */
  Future<void> incrementNotificationsCount() async {
    final prefs = await SharedPreferences.getInstance();
    final count = await getNotificationsCount();
    await prefs.setInt(AppConstants.notificationsCount, count + 1);
  }

  Future<void> resetNotificationsCount() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(AppConstants.notificationsCount, 0);
  }

  Future<int> getNotificationsCount() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    return prefs.getInt(AppConstants.notificationsCount) ?? 0;
  }

  /* ****************** Cart */
  Future addToCart(CartModel cartModel) async {
    final Box<CartModel> cartBox = await Hive.openBox(AppConstants.cartBox);
    await cartBox.put(cartModel.id, cartModel);
  }

  Future<List<CartModel>> getCartData() async {
    final Box<CartModel> cartBox = await Hive.openBox(AppConstants.cartBox);
    final cartModels = cartBox.values.toList();
    final expiredCartModels = [];

    for (var cartModel in cartModels) {
      if (DateTime.now().difference(cartModel.createdAt).inDays > 7) {
        expiredCartModels.add(cartModel);
        await deleteCartBy(cartModel.id);
      }
    }
    for (var cartModel in expiredCartModels) {
      cartModels.remove(cartModel);
    }
    log(cartModels);
    return cartModels;
  }

  // Future _addAllToCart(List<CartModel> cartModels) async {
  //   final Box<CartModel> cartBox = await Hive.openBox(AppConstants.cartBox);
  //   const Map<dynamic, CartModel> cartModelsMap = {};
  //   for (var cartModel in cartModels) {
  //     cartModelsMap[cartModel.id] = cartModel;
  //   }
  //   await cartBox.putAll(cartModelsMap);
  // }

  Future deleteCartBy(String id) async {
    final Box<CartModel> cartBox = await Hive.openBox(AppConstants.cartBox);
    cartBox.delete(id);
  }

  Future clearCart() async {
    final Box<CartModel> cartBox = await Hive.openBox(AppConstants.cartBox);
    cartBox.clear();
  }

  /* ****************** Favorite */
  Future addToFavorite(ProductModel productModel) async {
    final Box<ProductModel> favoriteBox =
        await Hive.openBox(AppConstants.favoriteBox);
    await favoriteBox.put(productModel.id, productModel);
  }

  Future<List<ProductModel>> getFavoriteData() async {
    final Box<ProductModel> favoriteBox =
        await Hive.openBox(AppConstants.favoriteBox);
    final products = favoriteBox.values.toList();

    log(products);
    return products;
  }

  Future deleteFromFavoriteBy(int id) async {
    final Box<ProductModel> favoriteBox =
        await Hive.openBox(AppConstants.favoriteBox);
    favoriteBox.delete(id);
  }
}
