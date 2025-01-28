// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/config/routes/app_routes.dart';
import 'package:ibn_sina/core/api/api_constants.dart';
import 'package:ibn_sina/core/services/service_locator.dart';
import 'package:ibn_sina/core/shared/shared_data.dart';
import 'package:ibn_sina/presentation/widgets/custom_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../config/routes/app_router.dart';
import '../../../core/helpers/helper_functions.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/enums.dart';
import '../../../cubit/main/main_cubit.dart';
import '../../../cubit/payment/payment_cubit.dart';
import '../../bottom_sheets/success_bottom_sheet.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/custom_loading.dart';

class PaymentScreen extends StatefulWidget {
  final String url;
  final OrderType orderType;
  final String? routeName;

  const PaymentScreen({
    super.key,
    required this.url,
    required this.orderType,
    this.routeName,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _webViewController = WebViewController();
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    _webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Theme.of(context).colorScheme.background)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            if (_isLoading == true) {
              setState(() {
                _isLoading = false;
              });
            }
          },
          onWebResourceError: (WebResourceError error) {
            // HelperFunctions.showToastMessage(context, error.description);
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('http://${ApiConstants.baseUrl}/api/')) {
              context.read<PaymentCubit>().completePayment(request.url);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await _popUntil();
        return await _webViewController.canGoBack();
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppStrings.payNow.tr(),
          leading: CustomBackButton(
            onTap: () async {
              _popUntil();
            },
          ),
        ),
        body: Stack(
          children: [
            WebViewWidget(controller: _webViewController),
            if (_isLoading) const FetchLoading(),
            BlocListener<PaymentCubit, PaymentState>(
              listener: (context, state) {
                _handleListener(state);
              },
              child: const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  _handleListener(PaymentState state) {
    HelperFunctions.submitActions(
      context,
      requestState: state.requestState,
      onLoaded: () {
        AppRouter.pop(context);
        showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(40.r),
            ),
          ),
          isScrollControlled: true,
          isDismissible: false,
          enableDrag: false,
          constraints: BoxConstraints(minWidth: double.maxFinite),
          builder: (context) {
            return SuccessBottomSheet(
              action: () async {
                while (await _webViewController.canGoBack()) {
                  _webViewController.goBack();
                }

                Future.delayed(Duration.zero, () {
                  _popUntil();
                });
              },
              title: AppStrings.paymentCompletedSuccessfully.tr(),
            );
          },
        );
      },
      onError: () async {
        AppRouter.pop(context);
        while (await _webViewController.canGoBack()) {
          _webViewController.goBack();
        }

        Future.delayed(Duration.zero, () {
          _popUntil();
        });
        HelperFunctions.showToastMessage(context, state.message);
      },
    );
  }

  Future<void> _popUntil() async {
    locator<SharedData>().isPaymentScreenOpened = true;
    if (await _webViewController.canGoBack()) {
      _webViewController.goBack();
    } else {
      AppRouter.popUntil(
        context,
        widget.routeName ?? widget.orderType.routeName,
      );
      if (widget.orderType.isProduct() ||
          widget.routeName == AppRoutes.productOrderDetails) {
        context.read<MainCubit>().goToScreenWithIndex(1, refresh: true);
      }
    }
  }
}
