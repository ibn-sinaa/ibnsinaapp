import 'package:ibn_sina/config/routes/app_routes.dart';
import 'package:ibn_sina/core/utils/app_strings.dart';

enum RequestState { loading, loaded, error, none }

enum CreateAccountStep { otp, create, success }

enum ForgotPasswordStep { phone, reset, success }

enum DeliveryType {
  branch(AppStrings.receivingFromTheBranch, 'branch'),
  home(AppStrings.homeDelivery, 'home');

  final String title;
  final String key;
  const DeliveryType(this.title, this.key);
}

extension DeliveryTypeExtension on DeliveryType {
  bool isBranch() => this == DeliveryType.branch;
  bool isHome() => this == DeliveryType.home;
}

enum OrderType {
  product(
    AppStrings.myOrders,
    AppRoutes.main,
  ),
  paper(
    AppStrings.paperPrintingRequests,
    AppRoutes.paperPrintingOrders,
  ),
  media(
    AppStrings.largeMediaPrinting,
    AppRoutes.mediaPrintingOrders,
  );

  final String title;
  final String routeName;

  const OrderType(this.title, this.routeName);
}

extension OrderTypeExtension on OrderType {
  bool isProduct() => this == OrderType.product;
  bool isPaper() => this == OrderType.paper;
  bool isMedia() => this == OrderType.media;
}

enum EducationalLevel {
  primary('ابتدائي', AppStrings.primary),
  middle('متوسط', AppStrings.middle),
  university('جامعي', AppStrings.university);

  final String key;
  final String value;

  const EducationalLevel(this.key, this.value);
}
