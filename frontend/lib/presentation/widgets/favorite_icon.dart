import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibn_sina/core/helpers/helper_functions.dart';
import 'package:ibn_sina/core/services/service_locator.dart';
import 'package:ibn_sina/core/shared/shared_data.dart';
import 'package:ibn_sina/data/models/product/product_model.dart';
import 'package:ibn_sina/presentation/dialogs/sign_in_warnign_dialog.dart';

import '../../config/themes/app_colors.dart';
import '../../core/utils/app_images.dart';
import '../../cubit/favorite/favorite_cubit.dart';
import 'custom_icon_button.dart';

class FavoriteIcon extends StatelessWidget {
  final ProductModel productModel;

  const FavoriteIcon({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, List<ProductModel>>(
      builder: (context, state) {
        final isFavorited = locator<SharedData>().isGuest
            ? false
            : context.read<FavoriteCubit>().isFavorited(productModel.id);
        return CustomIconButton(
          onTap: () {
            if (locator<SharedData>().isGuest) {
              HelperFunctions.showAppDialog<void>(
                context,
                barrierDismissible: true,
                child: const SignInWarningDialog(),
              );
            } else {
              if (isFavorited) {
                context
                    .read<FavoriteCubit>()
                    .deleteFromFavorite(productModel.id);
              } else {
                context.read<FavoriteCubit>().addToFavorite(productModel);
              }
            }
          },
          icon: isFavorited ? SvgImages.coloredFavorite : SvgImages.favorite,
          bgColor: Colors.white,
          iconColor: isFavorited
              ? Theme.of(context).colorScheme.secondary
              : AppColors.c37474F,
        );
      },
    );
  }
}
