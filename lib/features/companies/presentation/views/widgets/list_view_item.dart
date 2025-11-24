import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:link_task/core/constants/app_assets.dart';
import 'package:link_task/core/theme/app_color.dart';
import 'package:link_task/core/theme/app_text_styles.dart';

class ListViewItem extends StatelessWidget {
  const ListViewItem({super.key, required this.makeFav, required this.icon});

  final void Function()? makeFav;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: .zero,
      leading: ClipRRect(
        borderRadius: .circular(4),
        child: CachedNetworkImage(
          height: 85.h,
          width: 110.w,
          imageUrl:
              'https://olivedrab-manatee-515331.hostingersite.com/storage/companies/3.png',
          errorWidget: (context, url, error) => SizedBox(height: 100),
        ),
      ),
      title: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text('شركة التميز للديكور', style: AppTextStyle.styleRegular12),
          CircleAvatar(
            backgroundColor: AppColor.lightGreyColor,
            radius: 12.r,
            child: InkWell(onTap: makeFav, child: SvgPicture.asset(icon)),
          ),
        ],
      ),
      subtitle: Column(
        children: [
          Text(
            'خلافاَ للإعتقاد السائد فإن لوريم إيبسوم ليس نصاَ عشوائياً، بل إن له جذور في الأدب اللاتيني',
            style: AppTextStyle.styleRegular8,
          ),
          Row(
            spacing: 16,
            children: [
              Row(
                children: List.generate(5, (index) {
                  return Icon(Icons.star, color: Colors.amber, size: 12.sp);
                }),
              ),
              Row(
                spacing: 8,
                children: [
                  SvgPicture.asset(AppAssets.mapPinIcon),
                  Text('الرياض', style: AppTextStyle.styleMedium10),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
