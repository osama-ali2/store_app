import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yagot_app/constants/colors.dart';

import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          color: Colors.white,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              getTranslated(context,"verify_phone"),
              style: Theme.of(context).textTheme.headline1,
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
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
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            getTranslated(context,"enter_code"),
            style: Theme.of(context).textTheme.headline3,
          ),
          SizedBox(height: 10),
          Text(
            "+9660000000",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: "NeoSansArabic"),
          ),
          SizedBox(height: 35),
          SvgPicture.asset("assets/icons/phone_verify.svg"),
          SizedBox(height: 40),
          OtpTextField(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            fieldWidth: 65,
            numberOfFields: 4,
            enabledBorderColor: Colors.grey,
            borderWidth: 1,
            focusedBorderColor: Colors.black,
            borderRadius: BorderRadius.circular(10),
            showFieldAsBox: true,
            textStyle: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w400),
            decoration: InputDecoration(),
            onCodeChanged: (String code) {
            },
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
                getTranslated(context,"did_not_receive"),
                style: Theme.of(context).textTheme.headline3,
              ),
              Spacer(flex: 1),
              InkWell(
                onTap: () {},
                child: Text(
                  getTranslated(context,"resend"),
                  style: TextStyle(
                      color: grey1,
                      fontSize: 12.sp,
                      fontFamily: "NeoSansArabic",
                      fontWeight: FontWeight.normal),
                ),
              ),
              Spacer(flex: 6),
              Text(
                "01:00",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: "NeoSansArabic"),
              ),
            ],
          ),
          SizedBox(height: 50),
          _verifyButton(),
        ],
      ),
    );
  }

  Widget _verifyButton() {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: FlatButton(
        onPressed: () {
          // if (_formKey.currentState.validate()) {
          //   //todo: verify the phone
          // } else {}
        },
        color: Theme.of(context).primaryColor,
        child: Text(
          getTranslated(context,"verify"),
          style: TextStyle(color: Colors.white, fontFamily: "NeoSansArabic"),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
