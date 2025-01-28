import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/core/extensions/num_extension.dart';
import 'package:ibn_sina/core/responsive/responsive_helper.dart';

import '../../../../config/locale/language_manager.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_sizes.dart';

class AuthBody extends StatelessWidget {
  final String title;
  final Widget child;

  const AuthBody({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => HelperFunctions.unFocusKeyboard(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: (ScreenUtil().screenHeight * 0.45) + 32.5.h,
                child: Stack(
                  children: [
                    Container(
                      height: (ScreenUtil().screenHeight * 0.45),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        image: const DecorationImage(
                          image: AssetImage(
                            AppImages.authBackGround,
                          ),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: LanguageManager.isEnglish(context)
                            ? BorderRadius.only(
                                bottomRight: Radius.circular(AppSizes.radius.r),
                              )
                            : BorderRadius.only(
                                bottomLeft: Radius.circular(AppSizes.radius.r),
                              ),
                      ),
                      child: Center(
                        child: Container(
                          height: 152.w,
                          width: 152.w,
                          padding: EdgeInsets.symmetric(
                            horizontal: 15.w,
                            vertical: 23.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(AppSizes.radius.r),
                            color: Colors.white.withOpacity(0.11),
                          ),
                          child: Center(
                            child: Image.asset(
                              AppImages.logo,
                              fit: BoxFit.fill,
                              cacheHeight: 106.w.cacheSize(context),
                              cacheWidth: 122.w.cacheSize(context),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: LanguageManager.isEnglish(context)
                          ? AppSizes.horizontalPadding.w
                          : null,
                      right: LanguageManager.isEnglish(context)
                          ? null
                          : AppSizes.horizontalPadding.w,
                      bottom: 0,
                      child: Container(
                        height: getValueForScreenType(
                          context,
                          medium: 65,
                          large: 80,
                        ).h,
                        padding: EdgeInsets.symmetric(horizontal: 28.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(65.r),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 8.r),
                              blurRadius: 8.r,
                              color: Theme.of(context).shadowColor,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 33.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 42.w,
                  vertical: AppSizes.verticalPadding.h,
                ),
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
