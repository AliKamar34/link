import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:link_task/core/theme/app_color.dart';
import 'package:link_task/core/theme/app_text_styles.dart';

class GridViewItem extends StatelessWidget {
  const GridViewItem({super.key, required this.makeFav, required this.icon});

  final void Function()? makeFav;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: .circular(4),
          child: CachedNetworkImage(
            height: 94.h,
            imageUrl:
                'https://olivedrab-manatee-515331.hostingersite.com/storage/companies/3.png',
            errorWidget: (context, url, error) => SizedBox(height: 100),
          ),
        ),
        SizedBox(height: 7),
        ListTile(
          contentPadding: .zero,
          title: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text('شركة التميز للديكور', style: AppTextStyle.styleMedium12),
              CircleAvatar(
                backgroundColor: AppColor.lightGreyColor,
                radius: 12.r,
                child: InkWell(onTap: makeFav, child: SvgPicture.asset(icon)),
              ),
            ],
          ),
          subtitle: Text(
            'خلافاَ للإعتقاد السائد فإن لوريم إيبسوم ليس نصاَ عشوائياً، بل إن له جذور في الأدب اللاتيني',
            style: AppTextStyle.styleRegular8,
          ),
        ),
      ],
    );
  }
}
