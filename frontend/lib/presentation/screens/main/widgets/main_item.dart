import 'package:flutter/material.dart';
import 'package:ibn_sina/core/utils/enums.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_strings.dart';
import '../../favorite/favorite_screen.dart';
import '../../home/home_screen.dart';

import '../../cart/cart_screen.dart';
import '../../my_orders/my_orders_screen.dart';
import '../../settings/settings_screen.dart';

class MainItem {
  final int index;
  final Widget screen;
  final String icon;
  final String title;

  MainItem(this.index, this.screen, this.icon, this.title);
}

final mainItems = [
  MainItem(
    0,
    const HomeScreen(),
    SvgImages.home,
    AppStrings.home,
  ),
  MainItem(
    1,
    const MyOrdersScreen(orderType: OrderType.product),
    SvgImages.myOrders,
    AppStrings.myOrders,
  ),
  MainItem(
    2,
    const CartScreen(),
    SvgImages.cart,
    AppStrings.cart,
  ),
  MainItem(
    3,
    const FavoriteScreen(),
    SvgImages.favorite,
    AppStrings.favorite,
  ),
  MainItem(
    4,
    const SettingsScreen(),
    SvgImages.settings,
    AppStrings.settings,
  ),
];
