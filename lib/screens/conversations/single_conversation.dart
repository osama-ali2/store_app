import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:yagot_app/lang/app_locale.dart';
import 'package:yagot_app/screens/common/widgets/app_button.dart';
import 'package:yagot_app/screens/shipping_address/shipping_screen.dart';

class SingleConversationPage extends StatefulWidget {
  SingleConversationPage();

  @override
  _SingleConversationPageState createState() => _SingleConversationPageState();
}

class _SingleConversationPageState extends State<SingleConversationPage> {
  TextEditingController _sendFieldController;
  bool isProductVisible = true;

  @override
  void initState() {
    super.initState();
    _sendFieldController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _sendFieldController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        brightness: Brightness.light,
        elevation: 3,
        shadowColor: accent,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: accent,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isProductVisible ? _productCard() : Container(),
          _messagesList(),
          _sendField(),
        ],
      ),
    );
  }

  _productCard() {
    return Column(
      children: [
        Container(
          height: 80.h,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: accent.withOpacity(.06),
                  blurRadius: 12.w,
                  offset: Offset(0, 3))
            ],
            color: white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 50.h,
                width: 50.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: ExactAssetImage('assets/images/product1.png'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Product name',
                    style:
                        TextStyle(color: accent, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Owner name',
                    style: TextStyle(
                        color: accent,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal),
                  )
                ],
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isProductVisible = false;
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(6.r),
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: grey2.withOpacity(.2),
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset("assets/icons/cancel.svg"),
                ),
              ),
              AppButton(
                title: 'buy',
                borderRad: 25.r,
                width: 80.w,
                height: 30.h,
                fontSize: 12.sp,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShippingScreen()));
                },
              )
            ],
          ),
        ),
        Container(
          color: black.withOpacity(.1),
          width: double.infinity,
          height: .5,
        ),
      ],
    );
  }
  _messagesList() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, position) {
          return position.isEven ? _senderMessage() : _receiverMessage();
        },
        itemCount: 10,
      ),
    );
  }

  _senderMessage() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: ExactAssetImage("assets/images/person1.JPG"),
                  fit: BoxFit.cover),
            ),
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h),
              Container(
                width: MediaQuery.of(context).size.width * .75,
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  color: white2,
                  borderRadius: BorderRadiusDirectional.only(
                      topEnd: Radius.circular(15.r),
                      topStart: Radius.circular(15.r),
                      bottomEnd: Radius.circular(15.r),
                      bottomStart: Radius.circular(2.r)),
                ),
                child: Text(
                  'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color: accent,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                '03:30 PM',
                style: TextStyle(
                    color: accent,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 16.h),
            ],
          )
        ],
      ),
    );
  }

  _receiverMessage() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 24.h),
              Container(
                width: MediaQuery.of(context).size.width * .75,
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  color: white3,
                  borderRadius: BorderRadiusDirectional.only(
                      topEnd: Radius.circular(15),
                      topStart: Radius.circular(15),
                      bottomStart: Radius.circular(15),
                      bottomEnd: Radius.circular(2)),
                ),
                child: Text(
                  'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color: accent,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                '03:30 PM',
                style: TextStyle(
                    color: accent,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 16.h),
            ],
          ),
          SizedBox(width: 10.w),
          Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: ExactAssetImage("assets/images/person1.JPG"),
                  fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }

  _emptyMessages() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/icons/empty_messages.svg"),
          SizedBox(height: 20),
          Text(
            AppLocalization.of(context)
                .getTranslated("no_conversations_currently"),
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: accent),
          ),
        ],
      ),
    );
  }

  _sendField() {
    return Column(
      children: [
        Container(
          color: black.withOpacity(.7),
          width: double.infinity,
          height: .5,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset("assets/icons/photo.svg"),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: TextField(
                style: TextStyle(
                    color: accent,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.normal,
                    height: 1.5),
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                maxLines: 1,
                minLines: 1,
                controller: _sendFieldController,
                decoration: InputDecoration(
                  hintText: AppLocalization.of(context)
                      .getTranslated("send_field_hint"),
                  hintStyle: TextStyle(
                      color: grey1,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal),
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                "assets/icons/send.svg",
                matchTextDirection: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
