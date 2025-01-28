import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibn_sina/config/themes/app_colors.dart';
import '../../config/routes/app_router.dart';
import '../../config/routes/app_routes.dart';
import '../../core/utils/app_images.dart';
import '../../data/models/image_model.dart';
import 'custom_loading.dart';

class CachedImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final int? memCacheWidth;
  final int? memCacheHeight;
  final double? radius;
  final bool enableTopLeftRadius;
  final bool enableTopRightRadius;
  final bool enableBottomLeftRadius;
  final bool enableBottomRightRadius;
  final BoxFit? fit;
  final bool enableTap;
  final bool enableShadow;

  const CachedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.memCacheWidth,
    this.memCacheHeight,
    this.radius,
    this.enableTopLeftRadius = true,
    this.enableTopRightRadius = true,
    this.enableBottomLeftRadius = true,
    this.enableBottomRightRadius = true,
    this.fit,
    this.enableTap = true,
    this.enableShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    final heightValue = height == width ? height?.w : height?.h;
    final double radiusValue = radius?.r ?? 0;
    return GestureDetector(
      onTap: enableTap
          ? () {
              if (imageUrl.isNotEmpty) {
                AppRouter.pushNamed(
                  context,
                  AppRoutes.imageViewer,
                  arguments: ImageModel(images: [imageUrl]),
                );
              }
            }
          : null,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(enableTopLeftRadius ? radiusValue : 0),
            topRight: Radius.circular(enableTopRightRadius ? radiusValue : 0),
            bottomLeft:
                Radius.circular(enableBottomLeftRadius ? radiusValue : 0),
            bottomRight:
                Radius.circular(enableBottomRightRadius ? radiusValue : 0),
          ),
          color: enableShadow ? Colors.white : Colors.transparent,
          boxShadow: enableShadow
              ? [
                  BoxShadow(
                    blurRadius: 4.r,
                    color: AppColors.cCCCCCC,
                  )
                ]
              : null,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(enableTopLeftRadius ? radiusValue : 0),
            topRight: Radius.circular(enableTopRightRadius ? radiusValue : 0),
            bottomLeft:
                Radius.circular(enableBottomLeftRadius ? radiusValue : 0),
            bottomRight:
                Radius.circular(enableBottomRightRadius ? radiusValue : 0),
          ),
          child: imageUrl.isEmpty
              ? SvgPicture.asset(
                  SvgImages.noImage,
                  height: heightValue,
                  width: width?.w,
                  fit: BoxFit.fill,
                )
              : CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: fit ?? BoxFit.cover,
                  height: heightValue,
                  width: width?.w,
                  memCacheWidth: memCacheWidth,
                  memCacheHeight: memCacheHeight,
                  placeholder: (context, _) => const ImageLoading(),
                  errorWidget: (context, _, __) {
                    return FittedBox(
                      child: Icon(
                        Icons.image,
                        size: 100.r,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
