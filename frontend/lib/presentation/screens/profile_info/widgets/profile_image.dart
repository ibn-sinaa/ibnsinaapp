import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibn_sina/core/extensions/num_extension.dart';
import 'package:ibn_sina/core/helpers/helper_functions.dart';
import 'package:ibn_sina/core/services/service_locator.dart';
import 'package:ibn_sina/core/shared/shared_data.dart';
import 'package:ibn_sina/presentation/dialogs/sign_in_warnign_dialog.dart';
import '../../../../config/locale/language_manager.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../data/models/image_model.dart';
import '../../../bottom_sheets/file_bottom_sheet.dart';
import '../../../widgets/cached_image.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/app_routes.dart';

class ProfileImage extends StatefulWidget {
  final Future<bool> Function(File file) onUpdated;
  final String image;

  const ProfileImage({
    super.key,
    required this.onUpdated,
    required this.image,
  });

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  File? _image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140.w,
      width: 140.w,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(8.w),
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.cF6F8FA,
              boxShadow: [
                BoxShadow(
                  color: AppColors.cCCCCCC,
                  blurRadius: 6.r,
                  offset: Offset.zero,
                ),
              ],
            ),
            child: _image == null
                ? Center(
                    child: CachedImage(
                      imageUrl: widget.image,
                      width: 132,
                      height: 132,
                      memCacheHeight: 120.w.cacheSize(context),
                      memCacheWidth: 120.w.cacheSize(context),
                      radius: 140,
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      AppRouter.pushNamed(
                        context,
                        AppRoutes.imageViewer,
                        arguments: ImageModel(
                          images: [_image!.path],
                          isFile: true,
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(140.r),
                      child: Image.file(
                        _image!,
                        height: 132.w,
                        width: 132.w,
                        cacheHeight: 120.w.cacheSize(context),
                        cacheWidth: 120.w.cacheSize(context),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
          ),
          Align(
            alignment: Alignment(
              LanguageManager.isEnglish(context) ? -0.7 : 0.7,
              1.2,
            ),
            child: Material(
              color: Colors.transparent,
              child: IconButton(
                onPressed: () {
                  if (locator<SharedData>().isGuest) {
                    HelperFunctions.unFocusKeyboard();
                    HelperFunctions.showAppDialog<void>(
                      context,
                      barrierDismissible: true,
                      child: const SignInWarningDialog(),
                    );
                  } else {
                    showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(40.r),
                        ),
                      ),
                      isScrollControlled: true,
                      constraints: BoxConstraints(minWidth: double.maxFinite),
                      builder: (context) {
                        return FileBottomSheet(
                          onUpdated: (image) {
                            widget
                                .onUpdated(File(image.path))
                                .then((isUpdated) {
                              if (!isUpdated) {
                                _image = null;
                              }
                            });
                            setState(() {
                              _image = image;
                            });
                          },
                        );
                      },
                    );
                  }
                },
                icon: SvgPicture.asset(
                  SvgImages.edit,
                  width: 34.w,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
