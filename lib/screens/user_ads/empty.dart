import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:yagot_app/screens/common/widgets/app_button.dart';
import 'package:yagot_app/utilities/helper_functions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyAds extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: Text(
          getTranslated(context, "my_ads"),
          style: TextStyle(
            color: accent,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: black,
          ),
        ),
      ),
      body: _bodyContent(context),
    );
  }

  _bodyContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Spacer(flex: 6),
        SvgPicture.asset("assets/icons/empty_ads.svg"),
        Spacer(flex: 2),
        Text(
          getTranslated(context, "no_ads_currently"),
          style: TextStyle(
              color: accent, fontSize: 14.sp, fontWeight: FontWeight.bold),
        ),
        Spacer(flex: 1),
        Text(
          getTranslated(context, "you_can_add_new_ad"),
          style: TextStyle(
              color: accent, fontSize: 12.sp, fontWeight: FontWeight.w100),
        ),
        Spacer(flex: 3),
        Center(
          child: AppButton(
            onPressed: () {
              // if (_formKey.currentState.validate()) {
              //   //todo: verify the phone
              // } else {}
            },
            title: 'add_new_ad',
            width: 0.9.sw,
          ),
        ),
        Spacer(flex: 13),
      ],
    );
  }
}
