import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yagot_app/constants/colors.dart';

import 'package:yagot_app/utilities/helper_functions.dart';

class AppDialog extends StatelessWidget {
  final String title;

  final String icon;

  final Color color;
  final double borderSize;
  final String buttonLabel;

  final String button2Label;

  final Function onPressBtn;

  final Function onPressBtn2;

  const AppDialog({
    Key key,
    this.title,
    this.icon,
    this.color,
    this.borderSize = 0,
    this.buttonLabel,
    this.button2Label,
    this.onPressBtn,
    this.onPressBtn2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        borderRadius: BorderRadius.circular(8.r),
        child: Container(
          height: 230.h,
          width: 295.w,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(8.r),
            boxShadow: [
              BoxShadow(
                color: black.withOpacity(.2),
                offset: Offset(0, 1),
                blurRadius: 3,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 60.h,
                width: 60.w,
                padding: EdgeInsets.all(15.r),
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                child: (icon == null)
                    ? Icon(
                        Icons.error_outline,
                        color: Colors.white,
                      )
                    : Align(
                        child: SvgPicture.asset('assets/icons/$icon'),
                      ),
              ),
              Text(title),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _btn(context, onPressBtn, buttonLabel),
                  ..._buildBtn2(context)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildBtn2(BuildContext context) {
    if (button2Label != null || onPressBtn2 != null) {
      return [
        _divider(),
        _btn(context, onPressBtn2, button2Label),
      ];
    }
    return [Container()];
  }

  _btn(BuildContext context, Function onPressed, String label) {
    return TextButton(
      onPressed: onPressed,
      // shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(4.r),
      //     side: BorderSide(
      //       color: grey6,
      //       style: (borderSize == 0)
      //           ? BorderStyle.none
      //           : BorderStyle.solid,
      //       width: borderSize,
      //     )),
      child: Text(
        getTranslated(context, label),
        style: TextStyle(fontWeight: FontWeight.w400),
      ),
      style: TextButton.styleFrom(
          primary: accent,
          side: BorderSide(
            color: grey6,
            style: (borderSize == 0) ? BorderStyle.none : BorderStyle.solid,
            width: borderSize,
          ),
      ),
    );
  }

  _divider() {
    return Container(
      width: 1,
      height: 36.h,
      color: grey7,
    );
  }
}
