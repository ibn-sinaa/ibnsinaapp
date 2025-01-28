import 'dart:async';

import 'package:easy_localization/easy_localization.dart' as lang;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/core/responsive/responsive_helper.dart';
import 'package:ibn_sina/presentation/widgets/custom_button.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/utils/app_strings.dart';

class OtpField extends StatefulWidget {
  final Function(String otp) sendAction;
  final Future<bool> Function() resendAction;
  final String phone;
  final OtpFieldController controller;

  const OtpField({
    super.key,
    required this.sendAction,
    required this.resendAction,
    required this.phone,
    required this.controller,
  });

  @override
  State<OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  String _otp = '';

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      widget.controller.setFocus(0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.horizontalPadding.w,
        vertical: AppSizes.verticalPadding.h,
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Image.asset(
              AppImages.otp,
              width: 190.w,
              height: 190.w,
            ),
            SizedBox(
              height: 12.h,
            ),
            Text(
              '${AppStrings.codeIsSent.tr()}${widget.phone}',
              style: TextStyle(
                fontSize: 18.sp,
                color: AppColors.c2D2F3A,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 67.h,
            ),
            Directionality(
              textDirection: TextDirection.ltr,
              child: OTPTextField(
                controller: widget.controller,
                length: 4,
                width: double.infinity,
                fieldWidth: 73.w,
                style: TextStyle(
                  fontSize:
                      getValueForScreenType(context, small: 23, medium: 20).sp,
                  color: AppColors.c2D2F3A,
                  fontWeight: FontWeight.w500,
                  height: 2,
                ),
                outlineBorderRadius: 9.r,
                spaceBetween: 17.w,
                contentPadding: EdgeInsets.symmetric(vertical: 26.h),
                otpFieldStyle: OtpFieldStyle(
                  backgroundColor: Colors.white,
                  borderColor: AppColors.c707070.withOpacity(0.4),
                  enabledBorderColor: AppColors.c707070.withOpacity(0.4),
                  focusBorderColor:
                      Theme.of(context).primaryColor.withOpacity(0.4),
                ),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.box,
                onCompleted: widget.sendAction,
                onChanged: (otp) {
                  _otp = otp;
                },
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            OtpTimer(widget.resendAction),
            SizedBox(
              height: 32.h,
            ),
            CustomButton(
              onPressed: () => widget.sendAction(_otp),
              text: AppStrings.send.tr().toUpperCase(),
            ),
            SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom,
            ),
          ],
        ),
      ),
    );
  }
}

class OtpTimer extends StatefulWidget {
  final Future<bool> Function() resendAction;
  const OtpTimer(this.resendAction, {super.key});

  @override
  State<OtpTimer> createState() => _OtpTimerState();
}

class _OtpTimerState extends State<OtpTimer> {
  int _duration = 60;
  String _time = '01:00';

  Timer? _timer;

  @override
  void didChangeDependencies() {
    _startTimer();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () async {
            if (_duration <= 0) {
              widget.resendAction().then((isSent) {
                if (isSent) {
                  _startTimer();
                }
              });
            }
          },
          child: Text(
            AppStrings.resendCode.tr(),
            style: TextStyle(
              fontSize: 16.sp,
              color: _duration > 0
                  ? AppColors.c707070
                  : Theme.of(context).primaryColor,
            ),
          ),
        ),
        if (_duration > 0)
          SizedBox(
            width: 50.w,
            child: FittedBox(
              child: Text(
                _time,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.c2D2F3A,
                ),
              ),
            ),
          ),
      ],
    );
  }

  void _startTimer() {
    _duration = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_duration > 0) {
        setState(() {
          _duration--;
          final min = (_duration / 60).floor();
          final sec = (_duration % 60).floor();
          _time = '${min >= 10 ? min : '0$min'}:${sec >= 10 ? sec : '0$sec'}';
        });
      } else {
        _timer?.cancel();
      }
    });
  }
}
