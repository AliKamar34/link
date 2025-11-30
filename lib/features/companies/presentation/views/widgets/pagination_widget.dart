import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_task/core/theme/app_color.dart';
import 'package:link_task/core/theme/app_text_styles.dart';
import 'package:link_task/features/companies/domain/entities/pagination.dart';

class PaginationWidget extends StatelessWidget {
  const PaginationWidget({
    super.key,
    required this.pagination,
    required this.onPageChanged,
  });

  final Pagination pagination;
  final Function(int) onPageChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Row(
        spacing: 12.w,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildNavigationButton(
            icon: Icons.arrow_back_ios,
            isEnabled: pagination.currentPage > 1,
            onTap: () {
              if (pagination.currentPage > 1) {
                onPageChanged(pagination.currentPage - 1);
              }
            },
          ),
          ..._buildPageNumbers(),
          _buildNavigationButton(
            icon: Icons.arrow_forward_ios,
            isEnabled: pagination.currentPage < pagination.lastPage,
            onTap: () {
              if (pagination.currentPage < pagination.lastPage) {
                onPageChanged(pagination.currentPage + 1);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButton({
    required IconData icon,
    required bool isEnabled,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: isEnabled ? onTap : null,
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: isEnabled ? AppColor.primaryColor : AppColor.lightGreyColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(
          icon,
          size: 16.sp,
          color: isEnabled ? Colors.white : AppColor.darkGreyColor,
        ),
      ),
    );
  }

  List<Widget> _buildPageNumbers() {
    List<Widget> pageButtons = [];
    int start = (pagination.currentPage - 2).clamp(1, pagination.lastPage);
    int end = (pagination.currentPage + 2).clamp(1, pagination.lastPage);

    // First page
    if (start > 1) {
      pageButtons.add(_buildPageButton(1));
      if (start > 2) {
        pageButtons.add(_buildEllipsis());
      }
    }

    // Middle pages
    for (int i = start; i <= end; i++) {
      pageButtons.add(_buildPageButton(i));
    }

    // Last page
    if (end < pagination.lastPage) {
      if (end < pagination.lastPage - 1) {
        pageButtons.add(_buildEllipsis());
      }
      pageButtons.add(_buildPageButton(pagination.lastPage));
    }

    return pageButtons;
  }

  Widget _buildPageButton(int page) {
    bool isCurrentPage = page == pagination.currentPage;

    return InkWell(
      onTap: () => onPageChanged(page),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isCurrentPage ? AppColor.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isCurrentPage
                ? AppColor.primaryColor
                : AppColor.greyBorderColor,
          ),
        ),
        child: Text(
          '$page',
          style: AppTextStyle.styleMedium12.copyWith(
            color: isCurrentPage ? Colors.white : AppColor.textColor,
          ),
        ),
      ),
    );
  }

  Widget _buildEllipsis() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      child: Text(
        '...',
        style: AppTextStyle.styleMedium12.copyWith(
          color: AppColor.darkGreyColor,
        ),
      ),
    );
  }
}
