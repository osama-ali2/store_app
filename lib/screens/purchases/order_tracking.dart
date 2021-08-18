import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:yagot_app/models/purchase.dart';
import 'package:yagot_app/utilities/helper_functions.dart';

class OrderTracking extends StatelessWidget {
  final Purchase purchase;

  OrderTracking(this.purchase);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _bodyContent(context),
    );
  }

  Widget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: transparent,
      title: Text(getTranslated(context, "order_tracking")),
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
    );
  }

  Widget _bodyContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Spacer(flex: 1),
        _productCard(context),
        Spacer(flex: 1),
        Padding(
          padding:  EdgeInsetsDirectional.only(start:30.w),
          child: Text(
            getTranslated(context, "date"),
            style: _titleStyle,
          ),
        ),
        Spacer(flex: 1),
        Padding(
          padding:  EdgeInsetsDirectional.only(start:30.w),
          child: SizedBox(
            height: 320,
            child: Stack(
              children: [
                PositionedDirectional(
                  start: 25,
                  child: DottedLine(
                    lineLength: 320,
                    lineThickness: 1,
                    dashColor: grey6,
                    dashLength: 7,
                    dashGapLength: 4,
                    direction: Axis.vertical,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   _statusRow(context, "assets/icons/file.svg", "order_done",
                       purchase.dateTime),
                   _statusRow(
                       context, "assets/icons/box.svg", "underway", purchase.dateTime),
                   _statusRow(context, "assets/icons/truck.svg", "shipping_done",
                       purchase.dateTime),
                   _statusRow(context, "assets/icons/border_check_in.svg",
                       "delivery_done", purchase.dateTime),
                 ],
               ),
              ],
            ),
          ),
        ),
        Spacer(flex: 2),
      ],
    );
  }

  Widget _productCard(BuildContext context) {
    TextStyle _semiBoldText =
        TextStyle(fontWeight: FontWeight.w600, fontSize: 12.sp, height: 1.7);
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: white4, width: 1),
        boxShadow: [
          BoxShadow(
            color: accent.withOpacity(.06),
            spreadRadius: 2,
            offset: Offset(0, 3),
            blurRadius: 6,
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      padding:
          EdgeInsetsDirectional.only(start: 15, end: 24, bottom: 20, top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: ExactAssetImage(
              purchase.product.details.image,
            ))),
          ),
          SizedBox(width: 15),
          Text.rich(TextSpan(
            children: [
              TextSpan(text: purchase.product.details.title + "\n"),
              TextSpan(text: purchase.product.details.price + "\n"),
              TextSpan(
                text: getTranslated(context, "order_number") + ": ",
                style: _semiBoldText.copyWith(fontWeight: FontWeight.normal),
                children: [
                  TextSpan(text: purchase.orderNo + "\n", style: _semiBoldText),
                ],
              ),
              TextSpan(
                  text: purchase.dateTime,
                  style: _dateStyle.copyWith(fontSize: 10.sp)),
            ],
            style: _semiBoldText,
          )),
          Spacer(),
          Align(
            alignment: Alignment.center,
            child: Icon(CupertinoIcons.forward),
          ),
        ],
      ),
    );
  }

  final TextStyle _dateStyle = TextStyle(
      fontSize: 12.sp, color: grey2, fontWeight: FontWeight.w100);
  final TextStyle _titleStyle = TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600);

  Widget _statusRow(
      BuildContext context, String iconPath, String titleKey, String date) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: white1,
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(12.r),
            child: SvgPicture.asset(
              iconPath,
              color: primary,
            ),
          ),
          SizedBox(width: 30),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(getTranslated(context, titleKey), style: _titleStyle),

              Text(date, style: _dateStyle),
            ],
          ),
        ],
      ),
    );
  }
}
