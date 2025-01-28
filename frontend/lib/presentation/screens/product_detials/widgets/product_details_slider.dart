import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/core/extensions/num_extension.dart';
import '../../../../data/models/image_model.dart';

import '../../../../config/locale/language_manager.dart';
import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../../data/models/product/product_model.dart';
import '../../../widgets/cached_image.dart';
import '../../../widgets/custom_back_button.dart';
import '../../../widgets/custom_dots.dart';
import '../../../widgets/favorite_icon.dart';

class ProductDetailsSlider extends StatefulWidget {
  final ProductModel productModel;

  const ProductDetailsSlider({
    super.key,
    required this.productModel,
  });

  @override
  State<ProductDetailsSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<ProductDetailsSlider> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final height = ScreenUtil().screenHeight * 0.45;
    return SizedBox(
      height: height,
      child: Stack(
        children: [
          StatefulBuilder(builder: (context, refresh) {
            return Stack(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: height,
                    autoPlay: true,
                    viewportFraction: 1,
                    onPageChanged: ((index, reason) {
                      refresh(() {
                        _currentIndex = index;
                      });
                    }),
                  ),
                  items: widget.productModel.images.map((image) {
                    return Builder(
                      builder: (BuildContext context) {
                        return GestureDetector(
                          onTap: () {
                            AppRouter.pushNamed(
                              context,
                              AppRoutes.imageViewer,
                              arguments: ImageModel(
                                images: widget.productModel.images,
                                index: _currentIndex,
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.cF5F5F5,
                            ),
                            child: CachedImage(
                              height: height,
                              width: double.maxFinite,
                              memCacheHeight: height.cacheSize(context),
                              imageUrl: image,
                              enableTap: false,
                              fit: BoxFit.contain,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                Positioned(
                  left: 0.w,
                  right: 0.w,
                  bottom: 60.h,
                  child: CustomDots(
                    currentIndex: _currentIndex,
                    length: widget.productModel.images.length,
                    activeColor: Theme.of(context).colorScheme.secondary,
                    disabledColor: Colors.white,
                    activeHeight: 6,
                    activeWidth: 20,
                    unactiveHeight: 6,
                    unactiveWidth: 14,
                    isCircle: false,
                  ),
                ),
              ],
            );
          }),
          Align(
            alignment: Alignment(
              LanguageManager.isEnglish(context) ? -0.95 : 0.95,
              -0.9,
            ),
            child: const SafeArea(
              child: CustomBackButton(
                bgColor: Colors.white,
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(
              0.95,
              -0.9,
            ),
            child: SafeArea(
              child: FavoriteIcon(
                productModel: widget.productModel,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
