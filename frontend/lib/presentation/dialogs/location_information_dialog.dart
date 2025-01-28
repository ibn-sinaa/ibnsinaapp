import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/config/routes/app_router.dart';
import 'package:ibn_sina/core/helpers/helper_functions.dart';
import 'package:ibn_sina/core/helpers/validator_helper.dart';
import 'package:ibn_sina/core/utils/app_sizes.dart';
import 'package:ibn_sina/data/models/location_model.dart';
import 'package:ibn_sina/presentation/widgets/custom_button.dart';
import 'package:ibn_sina/presentation/widgets/custom_text_field.dart';

import '../../core/utils/app_strings.dart';

class LocationInformationDialog extends StatefulWidget {
  final LocationModel location;

  const LocationInformationDialog({
    super.key,
    required this.location,
  });

  @override
  State<LocationInformationDialog> createState() =>
      _LocationInformationDialogState();
}

class _LocationInformationDialogState extends State<LocationInformationDialog> {
  late final TextEditingController _addressController;
  late final TextEditingController _buildingNumberController;
  late final TextEditingController _apartmentNumberController;
  late final TextEditingController _floorNumberController;
  late final FocusNode _buildingNumberNode;
  late final FocusNode _apartmenNumbertNode;
  late final FocusNode _floorNumbertNode;
  late final GlobalKey<FormState> _formKey;
  var _autovalidateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController(text: widget.location.address);
    _buildingNumberController =
        TextEditingController(text: widget.location.buildingNumber);
    _apartmentNumberController =
        TextEditingController(text: widget.location.apartmentNumber);
    _floorNumberController =
        TextEditingController(text: widget.location.floorNumber);
    _buildingNumberNode = FocusNode();
    _apartmenNumbertNode = FocusNode();
    _floorNumbertNode = FocusNode();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _addressController.dispose();
    _buildingNumberController.dispose();
    _apartmentNumberController.dispose();
    _floorNumberController.dispose();
    _buildingNumberNode.dispose();
    _apartmenNumbertNode.dispose();
    _floorNumbertNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: HelperFunctions.unFocusKeyboard,
      child: Dialog(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.horizontalPadding.w,
            vertical: AppSizes.verticalPadding.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStrings.locationInformation.tr(),
                style: TextStyle(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Form(
                autovalidateMode: _autovalidateMode,
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _addressController,
                      nextNode: _buildingNumberNode,
                      textInputAction: TextInputAction.next,
                      labelText: AppStrings.address.tr(),
                      validator: (address) => ValidatorHelper.validateText(
                        address,
                        AppStrings.requiredField.tr(),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTextField(
                      controller: _buildingNumberController,
                      focusNode: _buildingNumberNode,
                      nextNode: _apartmenNumbertNode,
                      textInputAction: TextInputAction.next,
                      labelText: AppStrings.buildingNumber.tr(),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTextField(
                      controller: _apartmentNumberController,
                      focusNode: _apartmenNumbertNode,
                      nextNode: _floorNumbertNode,
                      textInputAction: TextInputAction.next,
                      labelText: AppStrings.apartmentNumber.tr(),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTextField(
                      controller: _floorNumberController,
                      focusNode: _floorNumbertNode,
                      textInputAction: TextInputAction.next,
                      labelText: AppStrings.floorNumber.tr(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 32.h,
              ),
              SizedBox(
                child: CustomButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      final location = LocationModel();
                      location.address = _addressController.text;
                      location.buildingNumber = _buildingNumberController.text;
                      location.apartmentNumber =
                          _apartmentNumberController.text;
                      location.floorNumber = _floorNumberController.text;
                      AppRouter.pop(context, location);
                    } else if (_autovalidateMode == AutovalidateMode.disabled) {
                      setState(() {
                        _autovalidateMode = AutovalidateMode.onUserInteraction;
                      });
                    }
                  },
                  text: AppStrings.confirm.tr().toUpperCase(),
                  width: double.maxFinite,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
