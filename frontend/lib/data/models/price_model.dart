class PriceModel {
  final num subTotal;
  final num vat;
  final num deliveryTax;
  final num coupon;
  final num total;

  PriceModel({
    required this.subTotal,
    required this.vat,
    required this.deliveryTax,
    required this.coupon,
    required this.total,
  });

  factory PriceModel.fromMap(Map<String, dynamic> map) {
    return PriceModel(
      subTotal: num.tryParse('${map['sub_total']}') ?? 0,
      vat: num.tryParse('${map['vat']}') ?? 0,
      deliveryTax: num.tryParse('${map['delivery_tax']}') ?? 0,
      coupon: num.tryParse('${map['coupon']}') ?? 0,
      total: num.tryParse('${map['total']}') ?? 0,
    );
  }
}
