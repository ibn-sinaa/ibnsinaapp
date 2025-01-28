import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:ibn_sina/core/responsive/responsive_helper.dart';

class prefixIcon extends StatelessWidget {
  const prefixIcon({super.key, required this.icon});

  final String icon;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon,
      height: getValueForScreenType(
        context,
        medium: null,
        large: 24.r,
      ),
    );
  }
}
