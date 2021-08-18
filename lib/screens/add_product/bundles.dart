import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:yagot_app/screens/buying_product/payment_methods.dart';
import 'package:yagot_app/screens/common/widgets/app_button.dart';
import 'package:yagot_app/utilities/helper_functions.dart';
import 'package:yagot_app/utilities/none_glow_scroll_behavior.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Bundles extends StatefulWidget {
  @override
  _BundlesState createState() => _BundlesState();
}

class _BundlesState extends State<Bundles> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _bodyContent(),
    );
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: white,
      title: Text(
        getTranslated(context, "bundles"),
      ),
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
    );
  }

  Widget _bodyContent() {
    return Padding(
      padding:  EdgeInsets.all(30.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _subtitle("you_can_access_more_settings"),
          SizedBox(height: 25),
          _bodyText(getTranslated(context, "choose_subscription")),
          SizedBox(height: 15),
          Expanded(
            child: ScrollConfiguration(
              behavior: NoneGlowScrollBehavior(),
              child: ListView.builder(
                itemBuilder: (context, position) {
                  return _bundleCard(position);
                },
                itemCount: 7,
              ),
            ),
          ),
          AppButton(title: 'subscribe',onPressed: (selectedIndex == -1)
              ? null
              : () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return PaymentMethodsScreen();
                },
              ),
            );
          },),
        ],
      ),
    );
  }

  Widget _subtitle(String textKey) {
    return Text(
      getTranslated(context, textKey),
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _bodyText(String text) {
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.w400),
    );
  }

  Widget _bundleCard(int position) {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 2.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: (selectedIndex == position) ? primary:white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: blue6.withOpacity(.1),
            offset: Offset(0, 1),
            blurRadius: 6,
          ),
        ],
      ),
      child: ListTile(
        onTap: () {
          setState(() {
            selectedIndex = position;
          });
        },
        leading: SvgPicture.asset("assets/icons/yagot_logo.svg"),
        title: _bodyText("اسم الباقة"),
        trailing: Text("50 ريال"),
      ),
    );
  }
}

