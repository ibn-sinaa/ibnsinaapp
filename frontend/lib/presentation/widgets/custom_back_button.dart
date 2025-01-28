import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ibn_sina/core/responsive/responsive_helper.dart';
import '../../config/locale/language_manager.dart';
import '../../config/routes/app_router.dart';
import '../../core/utils/app_images.dart';

import 'custom_icon_button.dart';

class CustomBackButton extends StatelessWidget {
  final Function()? onTap;
  final Color? bgColor;
  final Color? iconColor;
  final double? size;

  const CustomBackButton({
    super.key,
    this.onTap,
    this.bgColor,
    this.iconColor,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: LanguageManager.isEnglish(context) ? pi : 0,
      child: CustomIconButton(
        onTap: onTap == null ? () => AppRouter.pop(context) : onTap!,
        icon: SvgImages.back,
        size: size ?? getValueForScreenType(context, medium: 12, large: 16),
        bottomPadding: 0,
        bgColor: bgColor,
        iconColor: iconColor,
      ),
    );
  }
}
