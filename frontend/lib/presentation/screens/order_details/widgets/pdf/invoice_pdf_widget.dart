import 'package:pdf/widgets.dart' as pdf;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibn_sina/core/helpers/helper_functions.dart';
import 'package:ibn_sina/core/helpers/pdf_helper.dart';
import 'package:ibn_sina/core/utils/app_images.dart';
import 'package:ibn_sina/core/utils/app_strings.dart';

class InvoicePdfWidget extends StatelessWidget {
  const InvoicePdfWidget({
    super.key,
    required this.builder,
    required this.fileName,
  });

  final pdf.Widget Function(Uint8List logobytes) builder;
  final String fileName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          SvgImages.pdf,
          width: 24.w,
        ),
        TextButton(
          onPressed: () async {
            final logobytes = await HelperFunctions.loadLogo();
            PdfHelper.generate(
              body: builder(logobytes),

              // productInvoice(
              //   isEnglish: LanguageManager.isEnglish(context),
              //   productOrder: state.productOrder!,
              //   logobytes: logobytes,
              // ),
              fileName: fileName,
            ).then(
              (file) {
                if (file != null) {
                  HelperFunctions.openFile(file);
                }
              },
            );
          },
          child: Text(
            AppStrings.downloadInvoice.tr(),
            style: const TextStyle(height: 1.5),
          ),
        ),
      ],
    );
  }
}
