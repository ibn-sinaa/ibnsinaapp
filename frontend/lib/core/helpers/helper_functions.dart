// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ibn_sina/config/locale/language_manager.dart';
import 'package:ibn_sina/config/routes/app_router.dart';
import 'package:ibn_sina/config/routes/app_routes.dart';
import 'package:ibn_sina/core/utils/app_images.dart';
import 'package:ibn_sina/data/models/image_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

import '../../presentation/widgets/custom_loading.dart';
import '../utils/app_strings.dart';
import '../utils/enums.dart';

class HelperFunctions {
  const HelperFunctions._();

  static unFocusKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static showToastMessage(
    BuildContext context,
    String message, {
    int duration = 2,
  }) {
    ToastContext().init(context);
    Toast.show(
      message,
      textStyle: TextStyle(
        fontSize: 12.sp,
        color: Colors.white,
      ),
      duration: duration,
      gravity: Toast.bottom,
    );
  }

  static Future<T?> showAppDialog<T>(
    BuildContext context, {
    required Widget child,
    Color? bgColor,
    bool barrierDismissible = false,
  }) async {
    return await showDialog(
      context: context,
      barrierColor: bgColor ?? Colors.black.withOpacity(0.7),
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            return barrierDismissible;
          },
          child: child,
        );
      },
    );
  }

  static submitActions(
    BuildContext context, {
    required RequestState requestState,
    required Function() onLoaded,
    required Function() onError,
    String? loadingMessage,
    String? loadingSubmessage,
  }) {
    switch (requestState) {
      case RequestState.loading:
        unFocusKeyboard();
        showAppDialog(
          context,
          child: SubmitLoading(
            message: loadingMessage,
            submessage: loadingSubmessage,
          ),
        );
        break;
      case RequestState.loaded:
        onLoaded();
        break;
      case RequestState.error:
        onError();
        break;
      case RequestState.none:
        break;
    }
  }

  static shareApp(String url, [String? subject]) {
    Share.share(url, subject: subject);
  }

  static Future<Either<String, File?>> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    try {
      unFocusKeyboard();
      final XFile? image =
          await picker.pickImage(source: source, imageQuality: 80);
      if (image != null) {
        return Right(File(image.path));
      }
      return const Right(null);
    } catch (error) {
      return Left(error.toString());
    }
  }

  static Future<Either<String, List<File>>> pickFiles({
    BuildContext? context,
    List<String>? allowedExtensions,
    bool allowMultiple = false,
  }) async {
    unFocusKeyboard();
    try {
      List<File> files = [];

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowedExtensions: allowedExtensions,
        type: allowedExtensions == null ? FileType.any : FileType.custom,
        allowMultiple: allowMultiple,
        onFileLoading: (status) {
          if (context != null) {
            if (status == FilePickerStatus.picking) {
              showAppDialog(
                context,
                child: const FetchLoading(
                  color: Colors.white,
                ),
              );
            } else {
              if (ModalRoute.of(context)?.isCurrent != true) {
                AppRouter.pop(context);
              }
            }
          }
        },
      );
      if (result != null) {
        for (var file in result.files) {
          if (file.path != null) {
            files.add(File(file.path!));
          }
        }
      }
      return Right(files);
    } catch (error) {
      return Left(error.toString());
    }
  }

  static launchWebUrl(BuildContext context, String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      webViewConfiguration: const WebViewConfiguration(
        enableJavaScript: true,
      ),
    )) {
      showToastMessage(context, AppStrings.somethingWentWrongException.tr());
    }
  }

  static launchWhatsApp(BuildContext context, String phone) async {
    String url = '';

    if (Platform.isIOS) {
      url = 'https://wa.me/$phone';
    } else {
      url = 'whatsapp://send?phone=$phone';
    }
    launchWebUrl(context, url);
  }

  static launchDialer(BuildContext context, String phone) async {
    String url = 'tel:$phone';
    launchWebUrl(context, url);
  }

  static openGoogleMap(
    BuildContext context,
    double lat,
    double lng,
  ) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    return await launchWebUrl(context, googleUrl);
  }

  static String generateTimeBasedId() {
    return const Uuid().v1();
  }

  static bool get isKeyboardOpened =>
      WidgetsBinding.instance.window.viewInsets.bottom > 0;

  static String getPrice(num price) {
    return '${toStringAsFixed(price)} ${AppStrings.sar.tr()}';
  }

  static String toStringAsFixed(num value) {
    return value.toStringAsFixed(2);
  }

  static Future<bool> isConnectedToInternet() async {
    return InternetConnectionChecker().hasConnection;
  }

  static Future openFile(File file) async {
    await OpenFilex.open(file.path);
  }

  static Future<String> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor ?? '';
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id;
    }
    return '';
  }

  static String getFileName(String path) {
    return path.substring(path.lastIndexOf('/') + 1);
  }

  static Future<bool> hasLocationPermission() async {
    try {
      var isEnabled = true;

      if (!await Geolocator.isLocationServiceEnabled()) {
        final status = await Permission.location.request();
        if (status != PermissionStatus.granted) {
          isEnabled = false;
        }
      } else {
        if (!await Permission.location.isGranted) {
          final status = await Permission.location.request();
          if (status != PermissionStatus.granted) {
            isEnabled = false;
          }
        }
      }
      return isEnabled;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> isStorageHasPermission() async {
    final deviceInfo = DeviceInfoPlugin();

    var status = await Permission.storage.status;
    if (status.isGranted) {
      return true;
    } else {
      if (Platform.isAndroid) {
        final android = await deviceInfo.androidInfo;
        status = android.version.sdkInt < 33
            ? await Permission.storage.request()
            : PermissionStatus.granted;
      } else {
        status = await Permission.storage.request();
      }
      return status.isGranted;
    }
  }

  static Future<Uint8List> loadLogo() async {
    final bytes = await rootBundle.load(AppImages.splashLogo);
    return bytes.buffer.asUint8List();
  }

  static Future<String> getStorePath() async {
    final Directory? tempDir = await getExternalStorageDirectory();
    final filePath = Directory("${tempDir!.path}/files");
    if (await filePath.exists()) {
      return filePath.path;
    } else {
      await filePath.create(recursive: true);
      return filePath.path;
    }
  }

  static String handlePrintingSize(
    BuildContext context,
    int height,
    int width,
  ) {
    return LanguageManager.isEnglish(context)
        ? '${height} ${AppStrings.cm.tr()} ⅹ ${width} ${AppStrings.cm.tr()}'
        : '${AppStrings.cm.tr()} ${width} ⅹ ${AppStrings.cm.tr()} ${height}';
  }

  static void openAnyFile(BuildContext context, File file) {
    final ext = file.path.split('.').last;
    if (ext == 'pdf') {
      AppRouter.pushNamed(
        context,
        AppRoutes.pdfViewer,
        arguments: file.path,
      );
    } else if (ext == 'png' || ext == 'jpg' || ext == 'jpeg' || ext == 'gif') {
      AppRouter.pushNamed(
        context,
        AppRoutes.imageViewer,
        arguments: ImageModel(images: [file.path], isFile: true),
      );
    } else {
      HelperFunctions.openFile(file);
    }
  }
}

log(Object? object) {
  if (kDebugMode) {
    print(object);
  }
}
