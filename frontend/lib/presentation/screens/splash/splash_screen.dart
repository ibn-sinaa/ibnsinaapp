import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/routes/app_router.dart';
import '../../../core/utils/app_images.dart';
import '../../../core/utils/app_sizes.dart';
import '../../../cubit/splash/splash_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _scaleAnimation =
        Tween<double>(begin: 0.95, end: 1).animate(_animationController);

    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    context.read<SplashCubit>().goToNextRoute(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashStateLoaded) {
            AppRouter.pushReplacementNamed(
              context,
              state.route,
              arguments: state.introData,
            );
          }
          if (state is SplashStateError) {
            _animationController.forward();
          } else {
            _animationController.repeat(reverse: true);
          }
        },
        builder: ((context, state) {
          return Stack(
            children: [
              Image.asset(
                AppImages.splash,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
              AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Center(
                      child: Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Image.asset(
                          AppImages.splashLogo,
                          width: 224.w,
                          height: 224.w,
                        ),
                      ),
                    );
                  }),
              if (state is SplashStateError)
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.horizontalPadding.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            context.read<SplashCubit>().goToNextRoute(context);
                          },
                          icon: Icon(
                            Icons.refresh,
                            size: 20.w,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            state.message,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}
