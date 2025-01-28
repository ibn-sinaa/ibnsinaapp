import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:ibn_sina/core/helpers/helper_functions.dart';
import 'package:ibn_sina/data/models/option_data/option_data_model.dart';

// ignore: must_be_immutable
class MediaFormModel extends Equatable {
  final String id;
  File? file;
  OptionDataModel? materialType;
  int height;
  int width;
  int copiesCount;
  final TextEditingController controller;

  MediaFormModel({
    required this.id,
    required this.file,
    this.materialType,
    this.height = 0,
    this.width = 0,
    required this.copiesCount,
    required this.controller,
  });

  factory MediaFormModel.generateForm([File? file]) {
    return MediaFormModel(
      id: HelperFunctions.generateTimeBasedId(),
      file: file,
      copiesCount: 1,
      controller: TextEditingController(
        text: HelperFunctions.getFileName(
          file?.path ?? '',
        ),
      ),
    );
  }

  void resetData(File file) {
    this.file = file;
    materialType = null;
    height = 0;
    width = 0;
    copiesCount = 1;
  }

  bool isValid() =>
      file != null &&
      materialType != null &&
      width > 0 &&
      height > 0 &&
      copiesCount > 0;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'file': file!.path,
      'serviceType': materialType?.id,
      'height': height,
      'width': width,
      'copiesCount': copiesCount,
    };
  }

  @override
  List<Object> get props {
    return [id];
  }
}
