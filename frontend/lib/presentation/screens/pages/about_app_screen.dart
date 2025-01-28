import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibn_sina/presentation/widgets/custom_app_bar.dart';

import '../../../core/utils/app_strings.dart';
import '../../../cubit/page/page_cubit.dart';
import '../../widgets/custom_back_button.dart';
import 'page_body.dart';

class AboutAppaScreen extends StatelessWidget {
  const AboutAppaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.aboutApp.tr(),
        leading: const CustomBackButton(),
      ),
      body: PageBody(
        onError: () {
          context.read<PageCubit>().getAboutApp();
        },
      ),
    );
  }
}
