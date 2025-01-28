import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/presentation/widgets/custom_app_bar.dart';
import '../../../cubit/order_flow/order_flow_cubit.dart';
import '../../../cubit/product_details/product_details_cubit.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/custom_loading.dart';
import '../../widgets/error_widget.dart';

import '../../../core/helpers/helper_functions.dart';
import '../../../core/utils/app_sizes.dart';
import 'widgets/product_details_button.dart';
import 'widgets/product_details_slider.dart';
import 'widgets/product_details_widget.dart';
import 'widgets/required_quantity_widget.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String title;

  const ProductDetailsScreen({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => HelperFunctions.unFocusKeyboard(),
      child: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
        listener: (context, state) {
          if (state is ProductDetailsLoaded) {
            context.read<OrderFlowCubit>().generateCart(
                  state.productDetailsModel.productModel,
                  state.productDetailsModel.productModel.defaultOptions,
                );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: state is ProductDetailsLoaded
                ? null
                : CustomAppBar(
                    title: title,
                    leading: const CustomBackButton(),
                  ),
            body: SafeArea(
              child: Builder(
                builder: (ctx) {
                  if (state is ProductDetailsLoading) {
                    return const FetchLoading();
                  } else if (state is ProductDetailsError) {
                    return ErrorData(
                      onTap: () {
                        context.read<ProductDetailsCubit>().getProductDetails();
                      },
                      message: state.message,
                    );
                  } else if (state is ProductDetailsLoaded) {
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: ProductDetailsSlider(
                            productModel:
                                state.productDetailsModel.productModel,
                          ),
                        ),
                        Positioned(
                          left: AppSizes.horizontalPadding.w,
                          right: AppSizes.horizontalPadding.w,
                          bottom: 0,
                          top: ScreenUtil().screenHeight * 0.45 - 40.h,
                          child: Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  padding: EdgeInsets.only(
                                    bottom: AppSizes.verticalPadding.h,
                                    top: 0,
                                  ),
                                  child: Column(
                                    children: [
                                      ProductDetialWidget(
                                        productDetailsModel:
                                            state.productDetailsModel,
                                      ),
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                      RequiredQuantityWidget(
                                        amounts: state.productDetailsModel
                                            .productModel.amounts,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ProductDetailsButton(
                                options: state.productDetailsModel.options,
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
