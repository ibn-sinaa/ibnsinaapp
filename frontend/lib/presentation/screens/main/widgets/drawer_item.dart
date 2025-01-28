import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../cubit/main/main_cubit.dart';

class DrawerItem extends StatelessWidget {
  final Function() onTap;
  final String image;
  final String title;

  const DrawerItem({
    super.key,
    required this.onTap,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<MainCubit>().scaffoldKey.currentState!.closeDrawer();
        onTap();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 21.w,
          vertical: 12.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.cFAFCFF,
          borderRadius: BorderRadius.circular(60.r),
          border: Border.all(
            color: AppColors.c707070,
            width: 0.2.w,
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              image,
              width: 16.w,
              height: 16.w,
              colorFilter: AppColors.colorFilter(
                  Theme.of(context).colorScheme.secondary),
            ),
            SizedBox(
              width: 14.w,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                color: Theme.of(context).primaryColor,
                height: 1.7,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
