import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/routes/app_router.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_images.dart';

import '../../../config/locale/language_manager.dart';
import '../../../core/utils/app_sizes.dart';
import '../../../data/models/intro_model.dart';
import '../../widgets/cached_image.dart';
import 'widgets/intro_bottom_part.dart';
import 'widgets/intro_description.dart';
import 'widgets/intro_skip.dart';

class IntroScreen extends StatefulWidget {
  final List<IntroModel> introData;

  const IntroScreen({super.key, required this.introData});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  final _pageController = PageController();
  late final AnimationController _animationController;
  late final Animation<double> _fadeInOutAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      reverseDuration: const Duration(seconds: 1),
    );
    _fadeInOutAnimation = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1, end: 0),
          weight: 50,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0, end: 1),
          weight: 50,
        ),
      ],
    ).animate(_animationController);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 87.h,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      image: const DecorationImage(
                        image: AssetImage(
                          AppImages.introBackground,
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
                  ),
                ),
                Positioned.fill(
                  child: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 15.h,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IntroSkip(
                            onTap: _startNow,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 80.h,
                                bottom: 70.h,
                              ),
                              child: PageView.builder(
                                controller: _pageController,
                                onPageChanged: _animateToNextPage,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 30.w),
                                    child: CachedImage(
                                      imageUrl: widget.introData[index].image,
                                      radius: AppSizes.radius,
                                      enableShadow: false,
                                    ),
                                  );
                                },
                                itemCount: widget.introData.length,
                              ),
                            ),
                          ),
                          IntroDescription(
                            animationController: _animationController,
                            fadeInOutAnimation: _fadeInOutAnimation,
                            description:
                                widget.introData[_currentIndex].description,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: IntroBottomPart(
              startNow: _startNow,
              nextPage: _animateToNextPage,
              currentIndex: _currentIndex,
              isLastPage: _currentIndex == widget.introData.length - 1,
              length: widget.introData.length,
            ),
          ),
        ],
      ),
    );
  }

  _animateToNextPage([int? index]) {
    setState(() {
      _currentIndex = index ?? _currentIndex + 1;
      if (_animationController.status == AnimationStatus.completed) {
        _animationController.reverse();
      } else {
        _animationController.forward();
      }
      if (index == null) {
        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  _startNow() {
    AppRouter.pushReplacementNamed(context, AppRoutes.signIn);
  }
}
