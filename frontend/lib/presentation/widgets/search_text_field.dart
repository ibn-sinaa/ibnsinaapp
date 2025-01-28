import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/helpers/helper_functions.dart';
import '../../core/utils/app_images.dart';
import '../../core/utils/app_strings.dart';
import 'custom_text_field.dart';

class SearchTextField extends StatefulWidget {
  final Function(String value) onChanged;
  final Duration duration;

  const SearchTextField({
    super.key,
    required this.onChanged,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  Timer? _debouncer;
  final _searchController = TextEditingController();

  debounce(VoidCallback callback) {
    _debouncer?.cancel();
    _debouncer = Timer(widget.duration, callback);
  }

  @override
  void dispose() {
    _debouncer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: _searchController,
      hintText: AppStrings.search.tr(),
      prefixIcon: SvgPicture.asset(SvgImages.search),
      suffixIcon: _searchController.text.isNotEmpty
          ? IconButton(
              onPressed: () {
                HelperFunctions.unFocusKeyboard();
                setState(() {
                  _searchController.text = '';
                  widget.onChanged('');
                });
              },
              icon: Icon(
                Icons.close,
                color: Theme.of(context).colorScheme.secondary,
                size: 22.w,
              ),
            )
          : null,
      onChanged: (value) {
        debounce(() => widget.onChanged(value.toLowerCase()));
        if (_searchController.text.isEmpty ||
            _searchController.text.length == 1) {
          setState(() {});
        }
      },
    );
  }
}
