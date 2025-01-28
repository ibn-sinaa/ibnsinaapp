import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../data/models/settings_model.dart';

class ContactUsSocialMedias extends StatelessWidget {
  final SocialModel socialModel;

  const ContactUsSocialMedias({
    super.key,
    required this.socialModel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SocialMedia(
          onTap: () {
            HelperFunctions.launchWebUrl(context, socialModel.facebook);
          },
          image: SvgImages.facebook,
        ),
        SocialMedia(
          onTap: () {
            HelperFunctions.launchWebUrl(context, socialModel.twitter);
          },
          image: SvgImages.twitter,
        ),
        SocialMedia(
          onTap: () {
            HelperFunctions.launchWebUrl(context, socialModel.instagram);
          },
          image: SvgImages.insta,
        ),
        SocialMedia(
          onTap: () {
            HelperFunctions.launchWhatsApp(context, socialModel.whatsapp);
          },
          image: SvgImages.whatsApp,
        ),
      ],
    );
  }
}

class SocialMedia extends StatelessWidget {
  final Function() onTap;
  final String image;

  const SocialMedia({
    super.key,
    required this.onTap,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SvgPicture.asset(
        image,
        width: 55.w,
        height: 55.w,
      ),
    );
  }
}
