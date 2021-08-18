import 'package:flutter/material.dart';
import 'package:yagot_app/utilities/helper_functions.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  final String title;

  final Function onPressed;
  final double width;
  final double height;

  final bool isBordered;

  final Color bgColor;
  final double fontSize;
  final double borderRad;
  final bool loading;

  AppButton({
    this.title,
    this.onPressed,
    this.width,
    this.height,
    this.isBordered = false,
    this.bgColor,
    this.fontSize,
    this.borderRad,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(child: CircularProgressIndicator())
        : ElevatedButton(
            onPressed: onPressed,
            child: Text(
              getTranslated(context, title),
              style: TextStyle(
                color: (bgColor == null) ? white : primary,
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: bgColor ?? primary,
              shadowColor: accent.withOpacity(.16),
              minimumSize: Size(
                width ?? 1.sw,
                height ?? 50.h,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRad ?? 8.r),
              ),
              side: BorderSide(
                color: accent,
                width: 1,
                style: isBordered ? BorderStyle.solid : BorderStyle.none,
              ),
            ),
          );
  }
}
