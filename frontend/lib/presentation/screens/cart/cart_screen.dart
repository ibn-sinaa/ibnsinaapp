import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/presentation/widgets/custom_app_bar.dart';
import 'package:ibn_sina/presentation/widgets/custom_button.dart';
import '../../../config/locale/language_manager.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/helpers/helper_functions.dart';
import '../../../core/utils/app_sizes.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/enums.dart';
import '../../../cubit/cart/cart_cubit.dart';
import '../../../cubit/main/main_cubit.dart';
import 'widgets/coupon_field.dart';
import '../../widgets/custom_back_button.dart';
import 'widgets/cart_item.dart';
import '../../widgets/no_data.dart';
import '../../../config/routes/app_router.dart';
import '../../../cubit/refresh/refresh_cubit.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  final _couponController = TextEditingController();

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HelperFunctions.unFocusKeyboard();
      },
      child: BlocBuilder<RefreshCubit, bool>(
        builder: (context, state) {
          return Scaffold(
            appBar: CustomAppBar(
              customTitle: Text(
                AppStrings.cart.tr(),
              ),
              leading: CustomBackButton(
                onTap: () => context.read<MainCubit>().goToScreenWithIndex(0),
              ),
            ),
            body: BlocConsumer<CartCubit, CartState>(
              listener: (context, state) {
                _handleListener(state);
              },
              builder: (context, state) {
                return state.cartItems.isEmpty
                    ? Center(
                        child: NoData(
                          title: AppStrings.noProducts.tr(),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(
                          left: AppSizes.horizontalPadding.w,
                          right: AppSizes.horizontalPadding.w,
                          bottom: AppSizes.verticalPadding.h,
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                padding: EdgeInsets.symmetric(
                                  vertical: AppSizes.verticalPadding.h,
                                ),
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: ((context, index) {
                                  if (index == state.cartItems.length) {
                                    return Column(
                                      children: [
                                        SizedBox(
                                          height: 24.h,
                                        ),
                                        CouponField(
                                          couponState: state.couponState,
                                          couponController: _couponController,
                                        ),
                                      ],
                                    );
                                  } else {
                                    return CartItem(
                                      cartModel: state.cartItems[index],
                                    );
                                  }
                                }),
                                separatorBuilder: (_, __) {
                                  return SizedBox(
                                    height: 16.h,
                                  );
                                },
                                itemCount: state.cartItems.length + 1,
                              ),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            SizedBox(
                              child: CustomButton(
                                onPressed: () {
                                  AppRouter.pushNamed(
                                    context,
                                    AppRoutes.productCompletion,
                                    arguments: state,
                                  );
                                },
                                text: AppStrings.continue_.tr().toUpperCase(),
                                width: double.maxFinite,
                              ),
                            ),
                          ],
                        ),
                      );
              },
            ),
          );
        },
      ),
    );
  }

  _handleListener(CartState state) {
    if (state.couponState == RequestState.none) {
      _couponController.text = '';
    }
    if (state.couponState == RequestState.error) {
      HelperFunctions.showToastMessage(context, state.message);
    }
    if (state.couponState == RequestState.loaded) {
      HelperFunctions.showToastMessage(
          context,
          LanguageManager.isEnglish(context)
              ? '${state.discountValue} ${AppStrings.sar.tr()} ${AppStrings.hasBeenDiscounted.tr()}'
              : '${AppStrings.hasBeenDiscounted.tr()} ${state.discountValue} ${AppStrings.sar.tr()}');
    }
  }
}
