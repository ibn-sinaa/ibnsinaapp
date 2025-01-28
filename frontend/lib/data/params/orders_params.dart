class OrdersParams {
  final String orderStatus;
  final int page;

  OrdersParams({
    required this.orderStatus,
    required this.page,
  });

  Map<String, String> toParams() {
    return {
      'order_status': orderStatus,
      'page': page.toString(),
    };
  }
}
