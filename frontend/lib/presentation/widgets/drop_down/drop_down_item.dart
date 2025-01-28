import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:ibn_sina/core/utils/app_strings.dart';

class DropDownItem<T> extends Equatable {
  final String title;
  final T? value;

  const DropDownItem(
    this.title,
    this.value,
  );

  factory DropDownItem.init() => const DropDownItem('', null);

  bool get isEmpty => value == null;

  @override
  List<Object?> get props => [title, value];
}

final educationalLevelList = [
  AppStrings.primary.tr(),
  AppStrings.middle.tr(),
  AppStrings.university.tr(),
];
