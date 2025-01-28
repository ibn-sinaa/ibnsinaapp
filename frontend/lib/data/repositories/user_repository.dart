import '../data_sources/local/user_local_data_source.dart';
import '../models/cart/cart_model.dart';
import '../models/product/product_model.dart';
import '../models/user_model.dart';

class UserRepository {
  final UserLocalDataSource _userLocalDataSource;

  UserRepository(this._userLocalDataSource);

  saveUserData(UserModel userModel) {
    _userLocalDataSource.saveUserData(userModel);
  }

  UserModel getUserData() {
    return _userLocalDataSource.getUserData();
  }

  clearUserData() {
    _userLocalDataSource.clearUserData();
  }

  saveUserAuthenticatedStatus(bool status) {
    _userLocalDataSource.saveUserAuthenticatedStatus(status);
  }

  bool isUserAuthenticated() {
    return _userLocalDataSource.isUserAuthenticated();
  }

  saveGuestUser(bool isGuest) {
    _userLocalDataSource.saveGuestUser(isGuest);
  }

  bool isGuest() {
    return _userLocalDataSource.isGuest();
  }

  saveFirstTimeStatus() {
    _userLocalDataSource.saveFirstTimeStatus();
  }

  bool isFirstTime() {
    return _userLocalDataSource.isFirstTime();
  }

  /* ****************** Notifications */
  Future<void> incrementNotificationsCount() async {
    await _userLocalDataSource.incrementNotificationsCount();
  }

  Future<void> resetNotificationsCount() async {
    await _userLocalDataSource.resetNotificationsCount();
  }

  Future<int> getNotificationsCount() async {
    return await _userLocalDataSource.getNotificationsCount();
  }

  /* ****************** Cart */
  Future addToCart(CartModel cartModel) async {
    _userLocalDataSource.addToCart(cartModel);
  }

  Future<List<CartModel>> getCartData() async {
    return _userLocalDataSource.getCartData();
  }

  Future deleteCartBy(String id) async {
    _userLocalDataSource.deleteCartBy(id);
  }

  Future clearCart() async {
    _userLocalDataSource.clearCart();
  }

  /* ****************** Favorite */
  Future addToFavorite(ProductModel productModel) async {
    _userLocalDataSource.addToFavorite(productModel);
  }

  Future<List<ProductModel>> getFavoriteData() async {
    return _userLocalDataSource.getFavoriteData();
  }

  Future deleteFromFavoriteBy(int id) async {
    _userLocalDataSource.deleteFromFavoriteBy(id);
  }
}
