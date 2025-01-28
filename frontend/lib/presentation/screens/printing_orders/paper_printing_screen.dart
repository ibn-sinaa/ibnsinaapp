import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibn_sina/config/routes/app_router.dart';
import 'package:ibn_sina/config/routes/app_routes.dart';
import 'package:ibn_sina/core/helpers/helper_functions.dart';
import 'package:ibn_sina/core/utils/app_sizes.dart';
import 'package:ibn_sina/core/utils/app_strings.dart';
import 'package:ibn_sina/core/utils/enums.dart';
import 'package:ibn_sina/cubit/paper_printing/paper_printing_cubit.dart';
import 'package:ibn_sina/presentation/screens/printing_orders/widgets/copies_count_widget.dart';
import 'package:ibn_sina/presentation/screens/printing_orders/widgets/printing_color_widget.dart';
import 'package:ibn_sina/presentation/widgets/custom_app_bar.dart';
import 'package:ibn_sina/presentation/widgets/custom_button.dart';
import 'package:ibn_sina/presentation/widgets/upload_printing_files_widget.dart';
import 'package:ibn_sina/presentation/widgets/uploaded_printing_file_field.dart';
import 'package:ibn_sina/presentation/widgets/custom_loading.dart';
import 'package:ibn_sina/presentation/widgets/error_widget.dart';
import 'package:ibn_sina/presentation/widgets/option_widget.dart';
import 'package:ibn_sina/presentation/widgets/custom_back_button.dart';

class PaperPrintingScreen extends StatefulWidget {
  const PaperPrintingScreen({super.key});

  @override
  State<PaperPrintingScreen> createState() =>
      PpaperPrintingRequestsStateScreen();
}

class PpaperPrintingRequestsStateScreen extends State<PaperPrintingScreen> {
  final _fileNameController = TextEditingController();

  @override
  void dispose() {
    _fileNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: HelperFunctions.unFocusKeyboard,
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppStrings.paperPrintingRequests.tr(),
          leading: const CustomBackButton(),
        ),
        body: BlocBuilder<PaperPrintingCubit, PaperPrintingState>(
          builder: (context, state) {
            if (state.requestState == RequestState.loading) {
              return const FetchLoading();
            } else if (state.requestState == RequestState.error) {
              return ErrorData(
                onTap: () {
                  context.read<PaperPrintingCubit>().getInitialData();
                },
                message: state.message,
              );
            } else if (state.requestState == RequestState.loaded) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.horizontalPadding.w,
                  vertical: AppSizes.verticalPadding.h,
                ),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    state.file == null
                        ? UploadPrintingFilesWidget(
                            onUploaded: (files) {
                              context
                                  .read<PaperPrintingCubit>()
                                  .uploadFile(files.first);
                              _fileNameController.text =
                                  HelperFunctions.getFileName(files.first.path);
                            },
                            title: '${AppStrings.uploadFile.tr()} (pdf)',
                          )
                        : UploadedPrintingFileField(
                            fileNameController: _fileNameController,
                            file: state.file!,
                            pageCount: state.pageCount,
                            onFileChanged: _onFileChanged,
                          ),
                    SizedBox(
                      height: 16.h,
                    ),
                    PrintingColorwidget(
                      selectedPrintingColor: state.printingColor!,
                      printingColors: state.printingColors,
                      onChanged: context
                          .read<PaperPrintingCubit>()
                          .changePrintingColor,
                    ),
                    Divider(
                      height: 6.h,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      AppStrings.additionalOptions.tr(),
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    ...state.options.map(
                      (option) => OptionWidget(
                        option: option,
                        onTap: (optionData) {
                          context
                              .read<PaperPrintingCubit>()
                              .updateOptions(option, optionData);
                        },
                      ),
                    ),
                    CopiesCountWidget(
                      onChanged: (count) {
                        context
                            .read<PaperPrintingCubit>()
                            .changeCopiesCount(count);
                      },
                      initialCount: state.copiesCount,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    CustomButton(
                      onPressed: state.file == null
                          ? null
                          : () {
                              AppRouter.pushNamed(
                                context,
                                AppRoutes.paperCompletion,
                                arguments: state,
                              );
                            },
                      text: AppStrings.continue_.tr().toUpperCase(),
                      width: double.maxFinite,
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void _onFileChanged() {
    HelperFunctions.pickFiles(
      allowedExtensions: ['pdf'],
    ).then((value) {
      value.fold((failure) {
        HelperFunctions.showToastMessage(context, failure);
      }, (files) {
        if (files.isNotEmpty) {
          context.read<PaperPrintingCubit>().uploadFile(files.first);
          _fileNameController.text = HelperFunctions.getFileName(
            files.first.path,
          );
        }
      });
    });
  }
}
