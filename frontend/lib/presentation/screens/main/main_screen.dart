import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibn_sina/cubit/settings/settings_cubit.dart';
import '../../../core/helpers/helper_functions.dart';
import '../../../cubit/cart/cart_cubit.dart';
import '../../../cubit/my_orders/my_orders_cubit.dart';
import '../../dialogs/exit_dialog.dart';

import '../../../cubit/main/main_cubit.dart';
import '../../../cubit/notifications_count/notifications_count_cubit.dart';
import '../../../cubit/user/user_cubit.dart';
import 'widgets/main_bottom_nav_bar.dart';
import 'widgets/main_drawer.dart';
import 'widgets/main_item.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    context.read<UserCubit>().getUserData();
    context.read<SettingsCubit>().getAppSettings();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState appLifecycleState) {
    super.didChangeAppLifecycleState(appLifecycleState);
    if (appLifecycleState == AppLifecycleState.resumed) {
      context.read<NotificationsCountCubit>().getNotificationsCount();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        if (context.read<MainCubit>().state.index != 0) {
          context.read<MainCubit>().goToScreenWithIndex(0);
        }
        final result = await HelperFunctions.showAppDialog(
              context,
              barrierDismissible: true,
              child: const ExitDialog(),
            ) ??
            false;
        if (result == true) {
          SystemNavigator.pop();
        }
      },
      child: BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {
          if (state.index == 1 && state.refresh) {
            context.read<MyOrdersCubit>().getProductOrders(refresh: true);
            context.read<CartCubit>().getInitialData();
          } else if (state.index == 2 && state.refresh) {
            context.read<CartCubit>().getInitialData();
          }
        },
        builder: (context, state) {
          return Scaffold(
            key: context.read<MainCubit>().scaffoldKey,
            drawer: const MainDrawer(),
            body: IndexedStack(
              index: state.index,
              children: mainItems.map((item) => item.screen).toList(),
            ),
            bottomNavigationBar: MainBottomNavBar(currentIndex: state.index),
          );
        },
      ),
    );
  }
}
