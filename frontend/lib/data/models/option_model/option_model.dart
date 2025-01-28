import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ibn_sina/core/utils/app_strings.dart';
import '../option_data/option_data_model.dart';

part 'option_model.g.dart';

@HiveType(typeId: 3)
class OptionModel extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String type;
  @HiveField(3)
  final int byCopy;
  @HiveField(4)
  final List<OptionDataModel> data;

  const OptionModel({
    required this.id,
    required this.name,
    required this.type,
    this.byCopy = 0,
    required this.data,
  });

  factory OptionModel.fromMap(Map<String, dynamic> map) {
    return OptionModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      type: map['type'] ?? '',
      byCopy: map['by_copy'] ?? 0,
      data: map['data'] == null
          ? []
          : (map['data'] as List)
              .map(
                (optionData) => OptionDataModel.fromMap(optionData),
              )
              .toList(),
    );
  }

  factory OptionModel.fromOption(
      OptionModel option, List<OptionDataModel> optionsData) {
    return OptionModel(
      id: option.id,
      name: option.name,
      type: option.type,
      byCopy: option.byCopy,
      data: optionsData,
    );
  }

  factory OptionModel.generateMaterialOption(List<OptionDataModel> data) {
    return OptionModel(
      id: 1,
      name: AppStrings.materialType.tr(),
      type: 'radio',
      byCopy: 0,
      data: data,
    );
  }

  @override
  List<Object?> get props => [name, type];
}

@HiveType(typeId: 4)
class DefaultOptionModel extends Equatable {
  @HiveField(0)
  final String key;
  @HiveField(1)
  final String value;

  const DefaultOptionModel({
    required this.key,
    required this.value,
  });

  factory DefaultOptionModel.fromMap(Map<String, dynamic> map) {
    return DefaultOptionModel(
      key: map['key'] ?? '',
      value: map['value'] ?? '',
    );
  }

  @override
  List<Object?> get props => [key, value];
}
