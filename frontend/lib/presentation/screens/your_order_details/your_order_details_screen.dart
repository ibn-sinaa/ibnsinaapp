import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ibn_sina/config/routes/app_routes.dart';
import 'package:ibn_sina/core/services/service_locator.dart';
import 'package:ibn_sina/core/shared/shared_data.dart';
import 'package:ibn_sina/presentation/dialogs/sign_in_warnign_dialog.dart';
import 'package:ibn_sina/presentation/widgets/custom_app_bar.dart';
import 'package:ibn_sina/presentation/widgets/custom_button.dart';
import '../../../config/routes/app_router.dart';
import '../../../core/helpers/helper_functions.dart';
import '../../../core/utils/app_images.dart';
import '../../../core/utils/app_sizes.dart';
import '../../../core/utils/app_strings.dart';
import '../../../cubit/order_flow/order_flow_cubit.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/upload_file_widget.dart';
import '../../widgets/option_widget.dart';

import '../../../cubit/main/main_cubit.dart';
import '../../../data/models/option_model/option_model.dart';

class YourOrderDetailsScreen extends StatefulWidget {
  final List<OptionModel> options;

  const YourOrderDetailsScreen({
    super.key,
    required this.options,
  });

  @override
  State<YourOrderDetailsScreen> createState() => _YourOrderDetailsScreenState();
}

class _YourOrderDetailsScreenState extends State<YourOrderDetailsScreen> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => HelperFunctions.unFocusKeyboard(),
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppStrings.yourOrderDetails.tr(),
          leading: const CustomBackButton(),
        ),
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: AppSizes.verticalPadding.h,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final option = widget.options[index];
                  return OptionWidget(
                    option: option,
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.horizontalPadding.w,
                    ),
                    onTap: (optionData) {
                      if (optionData.isSelected) {
                        context
                            .read<OrderFlowCubit>()
                            .removeOption(optionData, option);
                      } else {
                        if (option.type == 'radio') {
                          context
                              .read<OrderFlowCubit>()
                              .addRadioOption(optionData, option);
                        } else {
                          context
                              .read<OrderFlowCubit>()
                              .addCheckBoxOption(optionData, option);
                        }
                      }
                    },
                  );
                },
                childCount: widget.options.length,
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.horizontalPadding.w,
                    ),
                    child: CustomTextField(
                      controller: _messageController,
                      hintText:
                          AppStrings.wouldYouLikeToTellUsAnythingElse.tr(),
                      prefixIcon: SvgPicture.asset(SvgImages.message),
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  UploadFileWidget(
                    onUpload: (file) {
                      context.read<OrderFlowCubit>().addFile(file?.path);
                    },
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(
                  top: 47.h,
                  left: AppSizes.horizontalPadding.w,
                  right: AppSizes.horizontalPadding.w,
                  bottom: AppSizes.verticalPadding.h,
                ),
                child: CustomButton(
                  onPressed: () {
                    if (locator<SharedData>().isGuest) {
                      HelperFunctions.unFocusKeyboard();
                      HelperFunctions.showAppDialog<void>(
                        context,
                        barrierDismissible: true,
                        child: const SignInWarningDialog(),
                      );
                    } else {
                      context
                          .read<OrderFlowCubit>()
                          .addToCart(_messageController.text);
                      AppRouter.popUntil(context, AppRoutes.main);
                      context
                          .read<MainCubit>()
                          .goToScreenWithIndex(2, refresh: true);
                      HelperFunctions.showToastMessage(
                        context,
                        AppStrings.addedToCart.tr(),
                      );
                    }
                  },
                  text: AppStrings.addToCart.tr(),
                  width: double.maxFinite,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
