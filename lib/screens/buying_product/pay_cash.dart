import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:yagot_app/screens/main/main_page_view.dart';
import 'package:yagot_app/screens/shared/app_button.dart';
import 'package:yagot_app/utilities/helper_functions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PayCash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
          padding:  EdgeInsets.all(30.w),
          child: AppButton(
            title: "back_to_home_page",
            onPressed: () {
              Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => MainPages()) , (route) => false);
            },
          ),
        ),
        Spacer(flex: 1),
      ],
    );
  }

  _successPopUp(BuildContext context) {
    return Center(
      child: Container(
        height: 230.h,
        width: 295.w,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(8),
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
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(color: green1, shape: BoxShape.circle),
              child: SvgPicture.asset("assets/icons/correct.svg"),
            ),
            Text(getTranslated(context, "payment_process_done_successfully")),
            FlatButton(
              onPressed: () {},
              height: 45.h,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: BorderSide(
                  color: grey6,
                  width: 1,
                ),
              ),
              child: Text(
                getTranslated(context, "add_new_product"),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }

  _deletePopUp(BuildContext context) {
    return Center(
      child: Container(
        height: 230.h,
        width: 295.w,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(8),
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
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(color: red1, shape: BoxShape.circle),
              child: SvgPicture.asset("assets/icons/remove.svg"),
            ),
            Text(getTranslated(context, "do_you_want_delete_image")),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _flatButton(context, "yes_remove", () {}),
                _divider(),
                _flatButton(context, "cancel", () {})
              ],
            )
          ],
        ),
      ),
    );
  }

  _flatButton(BuildContext context, String textKey, Function onPressed) {
    return FlatButton(
      onPressed: onPressed,
      child: Text(
        getTranslated(context, textKey),
        style: TextStyle(
          fontWeight: FontWeight.w400,
        ),
      ),
      color: Colors.transparent,
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
