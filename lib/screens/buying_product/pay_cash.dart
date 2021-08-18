import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:yagot_app/screens/main/main_page_view.dart';
import 'package:yagot_app/screens/common/widgets/app_button.dart';
import 'package:yagot_app/utilities/helper_functions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PayCash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: transparent,
        title: Text(
          getTranslated(context, "pay_cash"),
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
        Spacer(flex: 2),
        SvgPicture.asset("assets/icons/cash.svg"),
        SizedBox(height: 40.h),
        Text(
          getTranslated(context, "order_process_done_successfully"),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
            color: accent,
          ),
        ),
        SizedBox(height: 30.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 60.w),
          child: Text.rich(
            TextSpan(
              text: getTranslated(context, "receipt_message"),
              children: [
                TextSpan(
                    text: "00000000 NA",
                    style:
                        TextStyle(color: accent, fontWeight: FontWeight.w600)),
                TextSpan(
                  text: getTranslated(context, "successfully") + "\n",
                ),
                TextSpan(
                  text: getTranslated(context, "check_message"),
                  style: TextStyle(height: 1.8),
                )
              ],
            ),
            textAlign: TextAlign.center,
            style: TextStyle(wordSpacing: 2),
          ),
        ),
        Spacer(flex: 3),
        Padding(
          padding: EdgeInsets.all(30.r),
          child: AppButton(
            title: "back_to_home_page",
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MainPages()),
                  (route) => false);
            },
          ),
        ),
        Spacer(flex: 1),
      ],
    );
  }
}
