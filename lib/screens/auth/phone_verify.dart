import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yagot_app/constants/colors.dart';

import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yagot_app/screens/common/widgets/app_button.dart';
import 'package:yagot_app/utilities/helper_functions.dart';

class PhoneVerify extends StatefulWidget {
  @override
  _PhoneVerifyState createState() => _PhoneVerifyState();
}

class _PhoneVerifyState extends State<PhoneVerify> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: white,
        ),
        Scaffold(
          backgroundColor: transparent,
          appBar: AppBar(
            backgroundColor: transparent,
            title: Text(
              getTranslated(context, "verify_phone"),
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
        )
      ],
    );
  }

  Widget _bodyContent(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 40.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            getTranslated(context, "enter_code"),
            style: TextStyle(
                color: accent,
                fontSize: 14.sp,
                fontWeight: FontWeight.normal),
          ),
          SizedBox(height: 10),
          Text(
            "+9660000000",
            style: TextStyle(
              color: black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 35),
          SvgPicture.asset("assets/icons/phone_verify.svg"),
          SizedBox(height: 40),
          OtpTextField(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            fieldWidth: 65,
            numberOfFields: 4,
            enabledBorderColor: grey1,
            borderWidth: 1,
            focusedBorderColor: black,
            borderRadius: BorderRadius.circular(10.r),
            showFieldAsBox: true,
            textStyle: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w400),
            decoration: InputDecoration(),
            onCodeChanged: (String code) {},
            onSubmit: (String verificationCode) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Verification Code"),
                      content: Text('Code entered is $verificationCode'),
                    );
                  });
            }, // end onSubmit
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                getTranslated(context, "did_not_receive"),
                style: TextStyle(
                    color: accent,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal),
              ),
              Spacer(flex: 1),
              InkWell(
                onTap: () {},
                child: Text(
                  getTranslated(context, "resend"),
                  style: TextStyle(
                      color: grey1,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal),
                ),
              ),
              Spacer(flex: 6),
              Text(
                "01:00",
                style: TextStyle(
                  color: black,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          SizedBox(height: 50),
          AppButton(
            title: 'verify',
            onPressed: () {
              // if (_formKey.currentState.validate()) {
              //   //todo: verify the phone
              // } else {}
            },
          ),
        ],
      ),
    );
  }
}
