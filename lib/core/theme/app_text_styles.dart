import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTextStyle {
  static TextStyle styleRegular16 = GoogleFonts.cairo(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );
  static TextStyle styleRegular12 = GoogleFonts.cairo(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
  );
  static TextStyle styleMedium12 = GoogleFonts.cairo(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
  );
  static TextStyle styleRegular8 = GoogleFonts.elMessiri(
    fontSize: 8.sp,
    fontWeight: FontWeight.w400,
  );
  static TextStyle styleRegular10 = GoogleFonts.elMessiri(
    fontSize: 10.sp,
    fontWeight: FontWeight.w400,
  );
  static TextStyle styleMedium10 = GoogleFonts.cairo(
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle styleMedium14 = GoogleFonts.elMessiri(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );
  static TextStyle styleMedium14Cairo = GoogleFonts.cairo(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );
  static TextStyle styleMedium16 = GoogleFonts.cairo(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );
  static TextStyle styleBold16 = GoogleFonts.cairo(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
  );
  static TextStyle styleBold14 = GoogleFonts.cairo(
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
  );
}
