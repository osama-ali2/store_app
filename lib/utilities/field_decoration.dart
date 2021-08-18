import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yagot_app/constants/colors.dart';

class FieldDecoration extends InputDecoration {
  final String hint;

  FieldDecoration({
    this.hint,
  }) : super(
          hintText: hint,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            vertical: 15.h,
            horizontal: 15.w,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: accent.withOpacity(.2), width: 1),
          ),
        );
}
