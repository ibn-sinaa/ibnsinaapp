import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart' as lang;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/config/themes/app_colors.dart';
import 'package:ibn_sina/core/helpers/helper_functions.dart';
import 'package:ibn_sina/core/utils/app_sizes.dart';
import 'package:ibn_sina/core/utils/app_strings.dart';
import 'package:path/path.dart' as path;

class DownloadingFileWidget extends StatefulWidget {
  const DownloadingFileWidget({
    super.key,
    required this.fileUrl,
  });

  final String fileUrl;

  @override
  State<DownloadingFileWidget> createState() => _TileListState();
}

class _TileListState extends State<DownloadingFileWidget> {
  bool _isDowloading = false;
  bool _isFileExists = false;
  double _progress = 0;
  String _fileName = '';
  late String _filePath;
  late CancelToken _cancelToken;

  void _startDownload() async {
    if (await HelperFunctions.isStorageHasPermission()) {
      _cancelToken = CancelToken();
      final storePath = await HelperFunctions.getStorePath();
      _filePath = '$storePath/$_fileName';
      setState(() {
        _isDowloading = true;
        _progress = 0;
      });

      try {
        await Dio().download(widget.fileUrl, _filePath,
            onReceiveProgress: (count, total) {
          setState(() {
            _progress = (count / total);
          });
        }, cancelToken: _cancelToken);
        setState(() {
          _isDowloading = false;
          _isFileExists = true;
        });
      } catch (e) {
        HelperFunctions.showToastMessage(context, e.toString());
        setState(() {
          _isDowloading = false;
        });
      }
    }
  }

  void _cancelDownload() {
    _cancelToken.cancel();
    setState(() {
      _isDowloading = false;
    });
  }

  Future<void> _checkFileExit() async {
    final storePath = await HelperFunctions.getStorePath();
    _filePath = '$storePath/$_fileName';
    bool fileExistCheck = await File(_filePath).exists();
    setState(() {
      _isFileExists = fileExistCheck;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _fileName = path.basename(widget.fileUrl);
    });
    _checkFileExit();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Directionality(
          textDirection: TextDirection.ltr,
          child: Expanded(
            child: Text(
              _fileName,
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.c2D2F3A,
                height: 1.5,
              ),
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        SizedBox(
          width: 12.w,
        ),
        InkWell(
          onTap: () {
            if (_isFileExists) {
              HelperFunctions.openAnyFile(context, File(_filePath));
            } else if (_isDowloading) {
              _cancelDownload();
            } else {
              _startDownload();
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: AppSizes.borderWidth.r,
                )),
            child: Text(
              _isFileExists
                  ? AppStrings.open.tr()
                  : _isDowloading
                      ? AppStrings.cancel.tr()
                      : AppStrings.download.tr(),
              style: TextStyle(
                fontSize: 12.sp,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
        if (_isFileExists == false) ...[
          SizedBox(
            width: 12.w,
          ),
          if (_isDowloading == true)
            Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: _progress,
                  strokeWidth: 2.r,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.primary,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 4.h,
                    left: 4.w,
                    right: 4.w,
                  ),
                  child: FittedBox(
                    child: Text(
                      '${_progress.ceil() * 100}%',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                )
              ],
            )
          else
            Icon(
              Icons.download,
              size: 24.r,
              color: Theme.of(context).colorScheme.primary,
            )
        ],
      ],
    );
  }
}
