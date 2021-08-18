import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yagot_app/utilities/helper_functions.dart';

class ContactButton extends StatelessWidget {
  final String titleKey;

  final String iconPath;

  final Color color;

  final Color borderColor;

  final Color textColor;

  final Function onPressed;

  const ContactButton(
      {Key key,
      this.titleKey,
      this.iconPath,
      this.color,
      this.textColor,
      this.borderColor,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 50.h,
      minWidth: 130.w,
      elevation: 0,
      color: color,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: borderColor, width: 1),
        borderRadius: BorderRadius.circular(25.r),
      ),
      onPressed: onPressed,
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/$iconPath',
            color: textColor,
          ),
          SizedBox(width: 10.w),
          Text(
            getTranslated(context, titleKey),
            style: TextStyle(
              fontWeight: FontWeight.w100,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
