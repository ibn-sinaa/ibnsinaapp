import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/core/services/service_locator.dart';
import 'package:ibn_sina/core/shared/shared_data.dart';
import 'package:ibn_sina/core/utils/app_sizes.dart';
import 'package:ibn_sina/cubit/favorite/favorite_cubit.dart';
import 'package:ibn_sina/cubit/refresh/refresh_cubit.dart';
import 'package:ibn_sina/data/models/product/product_model.dart';
import 'package:ibn_sina/presentation/widgets/custom_app_bar.dart';
import 'package:ibn_sina/presentation/widgets/no_data.dart';
import 'package:ibn_sina/presentation/widgets/product_widget.dart';

import '../../../core/utils/app_strings.dart';
import '../../../cubit/main/main_cubit.dart';
import '../../widgets/custom_back_button.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RefreshCubit, bool>(builder: (context, _) {
      return Scaffold(
        appBar: CustomAppBar(
          title: AppStrings.favorite.tr(),
          leading: CustomBackButton(
            onTap: () => context.read<MainCubit>().goToScreenWithIndex(0),
          ),
        ),
        body: BlocBuilder<FavoriteCubit, List<ProductModel>>(
          builder: (context, products) {
            return products.isEmpty || locator<SharedData>().isGuest
                ? Center(
                    child: NoData(
                      title: AppStrings.noProducts.tr(),
                    ),
                  )
                : ListView.separated(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.horizontalPadding.w,
                      vertical: AppSizes.verticalPadding.h,
                    ),
                    itemBuilder: (context, index) {
                      return ProductWidget(
                        productModel: products[index],
                      );
                    },
                    separatorBuilder: (_, __) {
                      return SizedBox(
                        height: 13.5.h,
                      );
                    },
                    itemCount: products.length,
                  );
          },
        ),
      );
    });
  }
}
