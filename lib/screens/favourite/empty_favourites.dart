import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:yagot_app/lang/app_locale.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyFavourites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _bodyContent(context);
  }

  _bodyContent(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Spacer(flex: 4),
          SvgPicture.asset("assets/icons/empty_favourites.svg"),
          Spacer(flex: 1),
          Text(
            AppLocalization.of(context).getTranslated("no_products_currently"),
            style: TextStyle(
                color: accent,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold),
          ),
          Spacer(flex: 10),
        ],
      ),
    );
  }
}
