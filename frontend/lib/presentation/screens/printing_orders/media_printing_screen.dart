import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/config/routes/app_router.dart';
import 'package:ibn_sina/config/routes/app_routes.dart';
import 'package:ibn_sina/config/themes/app_colors.dart';
import 'package:ibn_sina/core/helpers/helper_functions.dart';
import 'package:ibn_sina/core/utils/app_images.dart';
import 'package:ibn_sina/core/utils/app_sizes.dart';
import 'package:ibn_sina/core/utils/app_strings.dart';
import 'package:ibn_sina/core/utils/enums.dart';
import 'package:ibn_sina/cubit/media_printing/media_printing_cubit.dart';
import 'package:ibn_sina/presentation/screens/printing_orders/widgets/media_printing_form.dart';
import 'package:ibn_sina/presentation/widgets/custom_app_bar.dart';
import 'package:ibn_sina/presentation/widgets/custom_button.dart';
import 'package:ibn_sina/presentation/widgets/custom_icon_button.dart';
import 'package:ibn_sina/presentation/widgets/custom_back_button.dart';
import 'package:ibn_sina/presentation/widgets/custom_loading.dart';
import 'package:ibn_sina/presentation/widgets/error_widget.dart';

class MediaPrintingScreen extends StatelessWidget {
  const MediaPrintingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: HelperFunctions.unFocusKeyboard,
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppStrings.largeMediaPrinting.tr(),
          leading: const CustomBackButton(),
          actions: [
            CustomIconButton(
              onTap: () {
                HelperFunctions.pickFiles(
                  allowMultiple: true,
                  context: context,
                ).then((value) {
                  value.fold((failure) {
                    HelperFunctions.showToastMessage(context, failure);
                  }, (files) {
                    if (files.isNotEmpty) {
                      context.read<MediaPrintingCubit>().generateForms(files);
                    }
                  });
                });
              },
              icon: SvgImages.plus,
              iconColor: Theme.of(context).colorScheme.secondary,
            )
          ],
        ),
        body: BlocBuilder<MediaPrintingCubit, MediaPrintingState>(
          builder: (context, state) {
            if (state.requestState == RequestState.loading) {
              return const FetchLoading();
            } else if (state.requestState == RequestState.error) {
              return ErrorData(
                onTap: () {
                  context.read<MediaPrintingCubit>().getInitialData();
                },
                message: state.message,
              );
            } else if (state.requestState == RequestState.loaded) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: AppSizes.verticalPadding.h,
                  left: AppSizes.horizontalPadding.w,
                  right: AppSizes.horizontalPadding.w,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.only(
                          top: AppSizes.verticalPadding.h,
                        ),
                        itemBuilder: (context, index) {
                          return MediaPrintingForm(
                            form: state.forms[index],
                            materialType: state.materialOption!,
                            length: state.forms.length,
                          );
                        },
                        separatorBuilder: (_, index) {
                          return Divider(
                            color: AppColors.c707070.withOpacity(0.3),
                            height: 50.h,
                          );
                        },
                        itemCount: state.forms.length,
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    CustomButton(
                      onPressed: context.read<MediaPrintingCubit>().isValid()
                          ? () {
                              HelperFunctions.unFocusKeyboard();
                              AppRouter.pushNamed(
                                context,
                                AppRoutes.mediaCompletion,
                                arguments: state,
                              );
                            }
                          : null,
                      text: AppStrings.continue_.tr().toUpperCase(),
                      width: double.maxFinite,
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
