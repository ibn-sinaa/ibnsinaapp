import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/core/services/service_locator.dart';
import 'package:ibn_sina/core/shared/shared_data.dart';
import 'package:ibn_sina/presentation/dialogs/sign_in_warnign_dialog.dart';
import 'package:ibn_sina/presentation/widgets/custom_app_bar.dart';
import 'package:ibn_sina/presentation/widgets/custom_button.dart';
import 'package:pdf_render/pdf_render.dart';

import '../../../core/helpers/helper_functions.dart';
import '../../../core/utils/app_sizes.dart';
import '../../../core/utils/app_strings.dart';
import '../../../cubit/send_quotation_request/send_quotation_request_cubit.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/upload_file_widget.dart';
import 'widgets/send_quotation_request_form.dart';

class SendQuotationRequestScreen extends StatefulWidget {
  const SendQuotationRequestScreen({super.key});

  @override
  State<SendQuotationRequestScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<SendQuotationRequestScreen> {
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();

  final _userNameNode = FocusNode();
  final _emailNode = FocusNode();
  final _phoneNode = FocusNode();
  final _messageNode = FocusNode();
  final _formState = GlobalKey<FormState>();
  File? _design;

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    _userNameNode.dispose();
    _emailNode.dispose();
    _phoneNode.dispose();
    _messageNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => HelperFunctions.unFocusKeyboard(),
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppStrings.sendQuotationRequest.tr(),
          leading: const CustomBackButton(),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.horizontalPadding.w,
            vertical: AppSizes.verticalPadding.h,
          ),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SendQuotationRequestForm(
                userNameController: _userNameController,
                emailController: _emailController,
                phoneController: _phoneController,
                messageController: _messageController,
                userNameNode: _userNameNode,
                emailNode: _emailNode,
                phoneNode: _phoneNode,
                messageNode: _messageNode,
                formState: _formState,
              ),
              SizedBox(
                height: 40.h,
              ),
              UploadFileWidget(
                onUpload: (file) async {
                  _design = file;

                  PdfDocument doc = await PdfDocument.openFile(_design!.path);
                  HelperFunctions.showToastMessage(
                      context, doc.pageCount.toString());
                },
              ),
              SizedBox(
                height: 50.h,
              ),
              CustomButton(
                onPressed: () {
                  HelperFunctions.unFocusKeyboard();
                  if (locator<SharedData>().isGuest) {
                    HelperFunctions.showAppDialog<void>(
                      context,
                      barrierDismissible: true,
                      child: const SignInWarningDialog(),
                    );
                  } else {
                    context
                        .read<SendQuotationRequestCubit>()
                        .sendQuotationRequest(_formState, _design);
                  }
                },
                text: AppStrings.sendRequest.tr().toUpperCase(),
                width: double.maxFinite,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
