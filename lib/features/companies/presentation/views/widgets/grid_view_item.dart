import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:link_task/core/constants/app_assets.dart';
import 'package:link_task/core/theme/app_color.dart';
import 'package:link_task/core/theme/app_text_styles.dart';
import 'package:link_task/features/companies/domain/entities/company.dart';
import 'package:skeletonizer/skeletonizer.dart';

class GridViewItem extends StatelessWidget {
  const GridViewItem({
    super.key,
    required this.makeFav,
    required this.icon,
    required this.company,
  });

  final void Function()? makeFav;
  final String icon;
  final Company company;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: .circular(4),
          child: CachedNetworkImage(
            height: 94.h,
            imageUrl: company.img,
            placeholder: (context, url) => Skeletonizer(
              child: Image.asset(AppAssets.noImage, height: 85.h, width: 110.w),
            ),
            errorWidget: (context, url, error) => Image.asset(
              AppAssets.noImage,
              fit: BoxFit.cover,
              height: 85.h,
              width: 110.w,
            ),
          ),
        ),
        SizedBox(height: 7),
        ListTile(
          contentPadding: .zero,
          title: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(company.name, style: AppTextStyle.styleMedium12),
              CircleAvatar(
                backgroundColor: AppColor.lightGreyColor,
                radius: 12.r,
                child: InkWell(onTap: makeFav, child: SvgPicture.asset(icon)),
              ),
            ],
          ),
          subtitle: Text(company.desc, style: AppTextStyle.styleRegular8),
        ),
      ],
    );
  }
}
