import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:link_task/core/constants/app_assets.dart';
import 'package:link_task/core/theme/app_color.dart';
import 'package:link_task/core/theme/app_text_styles.dart';
import 'package:link_task/features/companies/domain/entities/company.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ListViewItem extends StatelessWidget {
  const ListViewItem({
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
    return ListTile(
      contentPadding: .zero,
      leading: ClipRRect(
        borderRadius: .circular(4.r),
        child: Padding(
          padding: const EdgeInsetsDirectional.only(end: 8),
          child: CachedNetworkImage(
            height: 100.h,
            width: 100.w,
            imageUrl: company.img,
            placeholder: (context, url) => Skeletonizer(
              child: Image.asset(AppAssets.noImage, height: 100, width: 100),
            ),
            errorWidget: (context, url, error) => Image.asset(
              AppAssets.noImage,
              fit: BoxFit.cover,
              height: 100.h,
              width: 100.w,
            ),
          ),
        ),
      ),
      title: Text(company.name, style: AppTextStyle.styleRegular12),
      subtitle: Column(
        spacing: 4,
        children: [
          Text(company.desc, style: AppTextStyle.styleRegular8),
          Row(
            spacing: 16,
            children: [
              buildStars(double.parse(company.avgRates)),
              Row(
                spacing: 8,
                children: [
                  SvgPicture.asset(AppAssets.mapPinIcon),
                  Text(company.location, style: AppTextStyle.styleMedium10),
                ],
              ),
            ],
          ),
        ],
      ),
      trailing: Column(
        mainAxisAlignment: .start,
        children: [
          CircleAvatar(
            backgroundColor: AppColor.lightGreyColor,
            radius: 12.r,
            child: InkWell(onTap: makeFav, child: SvgPicture.asset(icon)),
          ),
        ],
      ),
    );
  }

  Widget buildStars(double rating) {
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;
    int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);

    return Row(
      children: [
        ...List.generate(fullStars, (index) {
          return Icon(Icons.star, color: Colors.amber, size: 12);
        }),
        if (hasHalfStar) Icon(Icons.star_half, color: Colors.amber, size: 12),
        ...List.generate(emptyStars, (index) {
          return Icon(Icons.star_border, color: Colors.grey, size: 12);
        }),
      ],
    );
  }
}
