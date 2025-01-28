// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/presentation/widgets/custom_app_bar.dart';
import '../../../config/themes/app_colors.dart';

import '../../widgets/custom_back_button.dart';
import '../../widgets/custom_loading.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../data/models/image_model.dart';

class ImageViewerScreen extends StatefulWidget {
  final ImageModel imageModel;

  const ImageViewerScreen({
    super.key,
    required this.imageModel,
  });

  @override
  State<ImageViewerScreen> createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<ImageViewerScreen> {
  late final _pageController;
  bool _showAppBar = true;

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.imageModel.index);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _showAppBar = !_showAppBar;
              });
            },
            child: PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: widget.imageModel.isFile
                      ? FileImage(File(widget.imageModel.images[index]))
                          as ImageProvider
                      : NetworkImage(widget.imageModel.images[index]),
                );
              },
              itemCount: widget.imageModel.images.length,
              loadingBuilder: (context, event) => Center(
                child: ImageLoading(
                  color: AppColors.cF5F7F9,
                ),
              ),
              pageController: _pageController,
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 100),
            left: 0,
            right: 0,
            top: _showAppBar ? 0 : -(100.h + ScreenUtil().statusBarHeight),
            child: CustomAppBar(
              systemOverlayStyle: _showAppBar
                  ? const SystemUiOverlayStyle(
                      statusBarIconBrightness: Brightness.light,
                    )
                  : null,
              backgroundColor: Colors.white10,
              leading: CustomBackButton(
                bgColor: Colors.transparent,
                iconColor: AppColors.cF5F7F9,
                size: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}
