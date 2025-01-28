import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ibn_sina/config/routes/app_router.dart';
import 'package:ibn_sina/config/themes/app_colors.dart';
import 'package:ibn_sina/core/helpers/helper_functions.dart';
import 'package:ibn_sina/core/utils/app_images.dart';
import 'package:ibn_sina/presentation/screens/pdf_viewer/widgets/pdf_icon.dart';
import 'package:ibn_sina/presentation/widgets/custom_app_bar.dart';
import 'package:ibn_sina/presentation/widgets/custom_icon_button.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

class PdfViewerScreen extends StatefulWidget {
  const PdfViewerScreen({
    super.key,
    required this.filePath,
  });

  final String filePath;

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  final _viewerController = PdfViewerController();

  @override
  void dispose() {
    _viewerController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        customTitle: Directionality(
          textDirection: TextDirection.ltr,
          child: Text(
            HelperFunctions.getFileName(widget.filePath),
          ),
        ),
        leading: CustomIconButton(
          onTap: () {
            AppRouter.pop(context);
          },
          icon: SvgImages.close,
          size: 12,
          bottomPadding: 0,
          iconColor: Theme.of(context).colorScheme.secondary,
        ),
      ),
      body: Stack(
        children: [
          PdfViewer.openFile(
            widget.filePath,
            viewerController: _viewerController,
            params: PdfViewerParams(
              padding: 0,
              pageDecoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.c707070.withOpacity(0.7),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PdfIcon(
                  onTap: () {
                    _viewerController.goToPage(pageNumber: 1);
                  },
                  icon: SvgImages.doubleArrow,
                  size: 18,
                  angle: pi,
                ),
                PdfIcon(
                  onTap: () {
                    final currentPage = _viewerController.currentPageNumber;
                    if (currentPage > 1) {
                      _viewerController.goToPage(
                        pageNumber: currentPage - 1,
                      );
                    }
                  },
                  icon: SvgImages.downArrow,
                  angle: -pi,
                ),
                PdfIcon(
                  onTap: () {
                    final currentPage = _viewerController.currentPageNumber;
                    if (currentPage < _viewerController.pageCount) {
                      _viewerController.goToPage(
                        pageNumber: _viewerController.currentPageNumber + 1,
                      );
                    }
                  },
                  icon: SvgImages.downArrow,
                ),
                PdfIcon(
                  onTap: () {
                    _viewerController.goToPage(
                      pageNumber: _viewerController.pageCount,
                    );
                  },
                  icon: SvgImages.doubleArrow,
                  size: 18,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
