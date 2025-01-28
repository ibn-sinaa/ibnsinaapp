import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibn_sina/cubit/branch/branch_cubit.dart';
import 'package:ibn_sina/cubit/cart/cart_cubit.dart';
import 'package:ibn_sina/cubit/city/city_cubit.dart';
import 'package:ibn_sina/cubit/refresh/refresh_cubit.dart';
import 'package:ibn_sina/cubit/settings/settings_cubit.dart';
import 'package:ibn_sina/data/repositories/app_repository.dart';
import 'package:ibn_sina/data/repositories/orders_repository.dart';
import 'core/services/service_locator.dart';
import 'cubit/favorite/favorite_cubit.dart';
import 'cubit/main/main_cubit.dart';
import 'cubit/order_flow/order_flow_cubit.dart';

import 'cubit/notifications_count/notifications_count_cubit.dart';
import 'cubit/user/user_cubit.dart';
import 'data/repositories/profile_repository.dart';
import 'data/repositories/user_repository.dart';

final globalProviders = [
  BlocProvider<MainCubit>(
    create: (context) => MainCubit(),
  ),
  BlocProvider<CartCubit>(
    create: (context) => CartCubit(
      locator<UserRepository>(),
      locator<OrdersRepository>(),
    )..getInitialData(),
  ),
  BlocProvider<UserCubit>(
    create: (context) => UserCubit(
      locator<ProfileRepository>(),
      locator<UserRepository>(),
    ),
  ),
  BlocProvider<OrderFlowCubit>(
    create: (context) => OrderFlowCubit(
      locator<UserRepository>(),
    ),
  ),
  BlocProvider<NotificationsCountCubit>(
    create: (context) => NotificationsCountCubit(
      locator<UserRepository>(),
    )..getNotificationsCount(),
  ),
  BlocProvider<FavoriteCubit>(
    create: (context) =>
        FavoriteCubit(locator<UserRepository>())..getFavoriteData(),
  ),
  BlocProvider<BranchCubit>(
    create: (context) => BranchCubit(locator<AppRepository>())..getBranches(),
  ),
  BlocProvider<CityCubit>(
    create: (context) => CityCubit(locator<AppRepository>())..getCities(),
  ),
  BlocProvider<SettingsCubit>(
    create: (context) => SettingsCubit(locator<AppRepository>()),
  ),
  BlocProvider<RefreshCubit>(
    create: (context) => RefreshCubit(),
  ),
];
