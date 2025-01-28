import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart' as lang;
import 'package:ibn_sina/core/helpers/helper_functions.dart';
import 'package:ibn_sina/core/utils/app_strings.dart';
import 'package:ibn_sina/core/utils/enums.dart';
import 'package:ibn_sina/data/models/branch_model.dart';
import 'package:ibn_sina/data/models/media_order_model.dart';
import 'package:ibn_sina/data/models/paper_order_model.dart';
import 'package:ibn_sina/data/models/product_order_model.dart';
import 'package:ibn_sina/data/models/price_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../../../../data/models/option_model/option_model.dart';

Widget productInvoice({
  required bool isEnglish,
  required ProductOrderModel productOrder,
  required Uint8List logobytes,
}) {
  return Directionality(
    textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _pdfLogo(logobytes),
        SizedBox(height: 12),
        if (productOrder.deliveryType.isBranch())
          _pdfBranch(productOrder.branch!, productOrder.orderStatus)
        else
          _pdfHome(
            city: productOrder.city!.name,
            address: productOrder.address,
            buildingNumber: productOrder.buildingNumber,
            apartmentNumber: productOrder.apartmentNumber,
            floorNumber: productOrder.floorNumber,
          ),
        Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          border: TableBorder.all(width: 0.3, color: PdfColors.grey500),
          columnWidths: {
            0: const FlexColumnWidth(1),
            1: const FlexColumnWidth(1),
            2: const FlexColumnWidth(1),
            3: const FlexColumnWidth(1),
          },
          children: [
            TableRow(
              decoration: const BoxDecoration(color: PdfColors.grey200),
              children: isEnglish
                  ? [
                      _pdfTableHeader(AppStrings.productName.tr(), isEnglish),
                      _pdfTableHeader(AppStrings.quantity.tr(), isEnglish),
                      _pdfTableHeader(AppStrings.price.tr(), isEnglish),
                      _pdfTableHeader(AppStrings.options.tr(), isEnglish),
                    ]
                  : [
                      _pdfTableHeader(AppStrings.options.tr(), isEnglish),
                      _pdfTableHeader(AppStrings.price.tr(), isEnglish),
                      _pdfTableHeader(AppStrings.quantity.tr(), isEnglish),
                      _pdfTableHeader(AppStrings.productName.tr(), isEnglish),
                    ],
            ),
            ...productOrder.items.map(
              (order) => TableRow(
                children: isEnglish
                    ? [
                        _pdfTableCell(order.productId.title),
                        _pdfTableCell(order.amount.toString()),
                        _pdfTableCell(
                            HelperFunctions.getPrice(order.productPrice)),
                        _pdfTableCell(_buildOptions(order.options)),
                      ]
                    : [
                        _pdfTableCell(_buildOptions(order.options)),
                        _pdfTableCell(
                            HelperFunctions.getPrice(order.productPrice)),
                        _pdfTableCell(order.amount.toString()),
                        _pdfTableCell(order.productId.title),
                      ],
              ),
            ),
          ],
        ),
        _pdfPaymentSummery(productOrder.prices, productOrder.deliveryType),
      ],
    ),
  );
}

Widget paperInvoice({
  required bool isEnglish,
  required PaperOrderModel paperOrder,
  required Uint8List logobytes,
}) {
  return Directionality(
    textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _pdfLogo(logobytes),
        SizedBox(height: 12),
        Text(
          AppStrings.mainInfo.tr(),
          style: TextStyle(
            fontSize: 7,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        _pdfTile(AppStrings.pageCount.tr(), paperOrder.pageNumbers.toString()),
        SizedBox(height: 4),
        _pdfTile(
            AppStrings.copiesCount.tr(), paperOrder.copyNumbers.toString()),
        SizedBox(height: 12),
        if (paperOrder.deliveryType.isBranch())
          _pdfBranch(paperOrder.branch!, paperOrder.orderStatus)
        else
          _pdfHome(
            city: paperOrder.city!.name,
            address: paperOrder.address,
            buildingNumber: paperOrder.buildingNumber,
            apartmentNumber: paperOrder.apartmentNumber,
            floorNumber: paperOrder.floorNumber,
          ),
        Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          border: TableBorder.all(width: 0.3, color: PdfColors.grey500),
          columnWidths: {
            0: const FlexColumnWidth(1),
            1: const FlexColumnWidth(1),
            2: const FlexColumnWidth(1),
          },
          children: [
            TableRow(
              decoration: const BoxDecoration(color: PdfColors.grey200),
              children: isEnglish
                  ? [
                      _pdfTableHeader(AppStrings.name.tr(), isEnglish),
                      _pdfTableHeader(AppStrings.type.tr(), isEnglish),
                      _pdfTableHeader(AppStrings.price.tr(), isEnglish),
                    ]
                  : [
                      _pdfTableHeader(AppStrings.price.tr(), isEnglish),
                      _pdfTableHeader(AppStrings.type.tr(), isEnglish),
                      _pdfTableHeader(AppStrings.name.tr(), isEnglish),
                    ],
            ),
            TableRow(
              children: isEnglish
                  ? [
                      _pdfTableCell(AppStrings.printingColor.tr()),
                      _pdfTableCell(paperOrder.paperColor.name),
                      _pdfTableCell(
                        HelperFunctions.getPrice(paperOrder.paperColor.price *
                            paperOrder.pageNumbers *
                            paperOrder.copyNumbers),
                      ),
                    ]
                  : [
                      _pdfTableCell(
                        HelperFunctions.getPrice(paperOrder.paperColor.price *
                            paperOrder.pageNumbers *
                            paperOrder.copyNumbers),
                      ),
                      _pdfTableCell(paperOrder.paperColor.name),
                      _pdfTableCell(AppStrings.printingColor.tr()),
                    ],
            ),
            ...paperOrder.items.map(
              (item) => TableRow(
                children: isEnglish
                    ? [
                        _pdfTableCell(item.paperOption.name),
                        _pdfTableCell(item.paperOptionData.name),
                        _pdfTableCell(
                          HelperFunctions.getPrice(item.optionCost),
                        ),
                      ]
                    : [
                        _pdfTableCell(
                          HelperFunctions.getPrice(item.optionCost),
                        ),
                        _pdfTableCell(item.paperOptionData.name),
                        _pdfTableCell(item.paperOption.name),
                      ],
              ),
            ),
          ],
        ),
        _pdfPaymentSummery(paperOrder.prices, paperOrder.deliveryType),
      ],
    ),
  );
}

Widget mediaInvoice({
  required bool isEnglish,
  required MediaOrderModel mediaOrder,
  required Uint8List logobytes,
}) {
  return Directionality(
    textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _pdfLogo(logobytes),
        SizedBox(height: 12),
        if (mediaOrder.deliveryType.isBranch())
          _pdfBranch(mediaOrder.branch!, mediaOrder.orderStatus)
        else
          _pdfHome(
            city: mediaOrder.city!.name,
            address: mediaOrder.address,
            buildingNumber: mediaOrder.buildingNumber,
            apartmentNumber: mediaOrder.apartmentNumber,
            floorNumber: mediaOrder.floorNumber,
          ),
        Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          border: TableBorder.all(width: 0.3, color: PdfColors.grey500),
          columnWidths: {
            0: const FlexColumnWidth(1),
            1: const FlexColumnWidth(1),
            2: const FlexColumnWidth(1),
            3: const FlexColumnWidth(1),
          },
          children: [
            TableRow(
              decoration: const BoxDecoration(color: PdfColors.grey200),
              children: isEnglish
                  ? [
                      _pdfTableHeader(AppStrings.materialType.tr(), isEnglish),
                      _pdfTableHeader(AppStrings.printingSize.tr(), isEnglish),
                      _pdfTableHeader(AppStrings.copiesCount.tr(), isEnglish),
                      _pdfTableHeader(AppStrings.total.tr(), isEnglish),
                    ]
                  : [
                      _pdfTableHeader(AppStrings.total.tr(), isEnglish),
                      _pdfTableHeader(AppStrings.copiesCount.tr(), isEnglish),
                      _pdfTableHeader(AppStrings.printingSize.tr(), isEnglish),
                      _pdfTableHeader(AppStrings.materialType.tr(), isEnglish),
                    ],
            ),
            ...mediaOrder.items.map(
              (item) => TableRow(
                children: isEnglish
                    ? [
                        _pdfTableCell(item.material.name),
                        _pdfTableCell('${item.width} X ${item.height} cm'),
                        _pdfTableCell(item.copyNumbers.toString()),
                        _pdfTableCell(
                            HelperFunctions.getPrice(item.totalPrice)),
                      ]
                    : [
                        _pdfTableCell(
                            HelperFunctions.getPrice(item.totalPrice)),
                        _pdfTableCell(item.copyNumbers.toString()),
                        _pdfTableCell('${item.width} X ${item.height} cm'),
                        _pdfTableCell(item.material.name),
                      ],
              ),
            ),
          ],
        ),
        _pdfPaymentSummery(mediaOrder.prices, mediaOrder.deliveryType),
      ],
    ),
  );
}

Widget _pdfLogo(Uint8List logobytes) {
  return Image(
    MemoryImage(logobytes),
    height: 70,
    width: 70,
    fit: BoxFit.contain,
  );
}

Widget _pdfTableHeader(String title, bool isEnglish) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
    child: Text(
      title,
      style: TextStyle(fontSize: isEnglish ? 7 : 8),
      textAlign: TextAlign.center,
    ),
  );
}

Widget _pdfBranch(
  BranchModel branch,
  String status,
) {
  return SizedBox(
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${status.contains('done') ? AppStrings.theBranchFromWhichItWasReceived.tr() : AppStrings.theBranchIsToBeReceivedFrom.tr()} : (${branch.name})',
          style: TextStyle(
            fontSize: 7,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        _pdfTile(AppStrings.address.tr(), branch.addressName),
        SizedBox(height: 4),
        _pdfTile(AppStrings.phoneNumber.tr(), branch.phone),
        SizedBox(height: 20),
      ],
    ),
  );
}

Widget _pdfHome({
  required String city,
  required String address,
  required String buildingNumber,
  required String apartmentNumber,
  required String floorNumber,
}) {
  return SizedBox(
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.addressDetails.tr(),
          style: TextStyle(
            fontSize: 7,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        _pdfTile(AppStrings.city.tr(), city),
        SizedBox(height: 4),
        Directionality(
          textDirection: TextDirection.rtl,
          child: _pdfTile(AppStrings.address.tr(), address),
        ),
        SizedBox(height: 4),
        _pdfTile(AppStrings.buildingNumber.tr(), buildingNumber),
        SizedBox(height: 4),
        _pdfTile(AppStrings.apartmentNumber.tr(), apartmentNumber),
        SizedBox(height: 4),
        _pdfTile(AppStrings.floorNumber.tr(), floorNumber),
        SizedBox(height: 20),
      ],
    ),
  );
}

Widget _pdfTile(String title, String content) {
  return Text(
    '* $title : $content',
    style: const TextStyle(fontSize: 7),
  );
}

Widget _pdfTableCell(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
    child: Text(
      title,
      style: const TextStyle(fontSize: 6),
      textAlign: TextAlign.center,
    ),
  );
}

Widget _pdfPriceItem(String title) {
  return SizedBox(
    width: 60,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        title,
        style: const TextStyle(fontSize: 6),
      ),
    ),
  );
}

Widget _pdfPaymentSummery(
  PriceModel prices,
  DeliveryType deliveryType,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 12),
      Row(
        children: [
          _pdfPriceItem(AppStrings.orderValue.tr()),
          _pdfPriceItem(HelperFunctions.getPrice(prices.subTotal)),
        ],
      ),
      Row(
        children: [
          _pdfPriceItem(AppStrings.addedValue.tr()),
          _pdfPriceItem(HelperFunctions.getPrice(prices.vat)),
        ],
      ),
      if (prices.coupon > 0)
        Row(
          children: [
            _pdfPriceItem(AppStrings.discountValue.tr()),
            _pdfPriceItem(HelperFunctions.getPrice(prices.coupon)),
          ],
        ),
      if (deliveryType.isHome())
        Row(
          children: [
            _pdfPriceItem(AppStrings.shippingCost.tr()),
            _pdfPriceItem('${prices.deliveryTax} ${AppStrings.sar.tr()}'),
          ],
        ),
      SizedBox(
        width: 90,
        child: Divider(thickness: 0.3, height: 8, color: PdfColors.grey500),
      ),
      Row(
        children: [
          _pdfPriceItem(AppStrings.total.tr()),
          _pdfPriceItem('${prices.total} ${AppStrings.sar.tr()}'),
        ],
      ),
      SizedBox(height: 4),
      SizedBox(
          width: 90,
          child: Column(
            children: [
              Divider(thickness: 0.3, height: 1, color: PdfColors.grey500),
              Divider(thickness: 0.3, height: 1, color: PdfColors.grey500),
            ],
          )),
    ],
  );
}

String _buildOptions(List<DefaultOptionModel> options) {
  String optionsInStr = '';
  for (var option in options) {
    optionsInStr +=
        '${optionsInStr.isNotEmpty ? '\n' : ''}* ${option.key} : ${option.value}';
  }
  return optionsInStr;
}
