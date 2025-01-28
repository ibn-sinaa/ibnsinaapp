import 'dart:io';

import 'package:flutter/services.dart';
import 'package:ibn_sina/core/helpers/helper_functions.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfHelper {
  static late ThemeData _theme;

  static Future<void> init() async {
    _theme = ThemeData.withFont(
      base: Font.ttf(await rootBundle.load('assets/fonts/Arial-Regular.ttf')),
      bold: Font.ttf(await rootBundle.load('assets/fonts/Arial-Bold.ttf')),
    );
  }

  static Future<File?> generate({
    required String fileName,
    required Widget body,
    Widget? header,
    Widget? footer,
  }) async {
    final pdf = Document();

    pdf.addPage(
      Page(
        theme: _theme,
        pageFormat: PdfPageFormat.roll80,
        orientation: PageOrientation.portrait,
        build: (context) {
          return body;
        },
      ),
    );

    return await PdfHelper.saveDocument(fileName: fileName, pdf: pdf);
  }

  static Future<File?> saveDocument({
    required String fileName,
    required Document pdf,
  }) async {
    if (await HelperFunctions.isStorageHasPermission()) {
      final bytes = await pdf.save();

      final storePath = await HelperFunctions.getStorePath();
      final file = File('$storePath/$fileName');
      final isFileExists = await file.exists();

      return isFileExists ? file : await file.writeAsBytes(bytes);
    }
    return null;
  }
}
