import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibn_sina/presentation/widgets/row_item.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../data/models/branch_model.dart';

class BranchItemWidget extends StatelessWidget {
  final BranchModel branchModel;

  const BranchItemWidget({
    super.key,
    required this.branchModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 7.w,
        right: 7.w,
        top: 7.h,
        bottom: 18.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9.r),
        border: Border.all(
          color: AppColors.cCCCCCC,
          width: AppSizes.borderWidth.w,
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            offset: const Offset(0, 0),
            blurRadius: 2.r,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: 11.h,
              horizontal: 13.w,
            ),
            decoration: BoxDecoration(
              color: AppColors.cF8F8F8,
              borderRadius: BorderRadius.circular(9.r),
            ),
            child: RowItem(
              title: branchModel.city.name,
              content: branchModel.name,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Column(
              children: [
                _RowItem(
                  image: SvgImages.location,
                  content: branchModel.addressName,
                  onTap: () {
                    HelperFunctions.openGoogleMap(
                      context,
                      branchModel.lat,
                      branchModel.lng,
                    );
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                _RowItem(
                  image: SvgImages.phone,
                  content: branchModel.phone,
                  onTap: () {
                    HelperFunctions.launchDialer(context, branchModel.phone);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RowItem extends StatelessWidget {
  final Function()? onTap;
  final String image;
  final String content;

  const _RowItem({
    this.onTap,
    required this.image,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: [
            SvgPicture.asset(
              image,
              width: 16.w,
              height: 16.w,
            ),
            SizedBox(
              width: 16.w,
            ),
            Expanded(
              child: Text(
                content,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Theme.of(context).primaryColor,
                  height: 1.3,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:ibn_sina/config/themes/app_colors.dart';
// import 'package:ibn_sina/core/utils/app_sizes.dart';

// class BranchItemWidget extends StatelessWidget {
//   final String title;
//   final String content;
//   final String image;
//   final bool isLocation;

//   const BranchItemWidget({
//     super.key,
//     required this.title,
//     required this.content,
//     required this.image,
//     this.isLocation = true,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(
//         left: 7.w,
//         right: 7.w,
//         top: 7.h,
//         bottom: 18.h,
//       ),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(9.r),
//         border: Border.all(
//           color: AppColors.cCCCCCC,
//           width: AppSizes.borderWidth.w,
//         ),
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Theme.of(context).shadowColor,
//             offset: const Offset(0, 0),
//             blurRadius: 2.r,
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Container(
//             width: double.infinity,
//             padding: EdgeInsets.symmetric(
//               vertical: 11.h,
//               horizontal: 13.w,
//             ),
//             decoration: BoxDecoration(
//               color: AppColors.cF8F8F8,
//               borderRadius: BorderRadius.circular(9.r),
//             ),
//             child: Text(
//               title,
//               style: TextStyle(
//                 fontSize: 13.sp,
//                 color: AppColors.c37474F,
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 10.h,
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 6.w),
//             child: isLocation
//                 ? Row(
//                     children: [
//                       SvgPicture.asset(
//                         image,
//                         width: 14.w,
//                       ),
//                       SizedBox(
//                         width: 16.w,
//                       ),
//                       Text(
//                         content,
//                         style: TextStyle(
//                           fontSize: 16.sp,
//                           color: Theme.of(context).primaryColor,
//                           height: 2,
//                         ),
//                       )
//                     ],
//                   )
//                 : Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Text(
//                         content,
//                         style: TextStyle(
//                           fontSize: 16.sp,
//                           color: Theme.of(context).primaryColor,
//                           height: 2,
//                         ),
//                       ),
//                       SizedBox(
//                         width: 16.w,
//                       ),
//                       SvgPicture.asset(
//                         image,
//                         width: 14.w,
//                       ),
//                     ],
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }
