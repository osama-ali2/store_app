import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:yagot_app/screens/buying_product/add_credit_card.dart';
import 'package:yagot_app/screens/buying_product/pay_cash.dart';
import 'package:yagot_app/utilities/helper_functions.dart';

class PaymentMethodsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: transparent,
        title: Text(
          getTranslated(context, "payment_methods"),
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
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 30.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getTranslated(context, "choose_payment_method"),
              style: TextStyle(
                color: accent,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30.h),
            _paymentMethodCard(context, getTranslated(context, "credit_card"),
                "assets/icons/credit_card.svg", AddCreditCard()),
            _paymentMethodCard(context, getTranslated(context, "bank_transfer"),
                "assets/icons/bank.svg", null),
            _paymentMethodCard(context, getTranslated(context, "pay_cash"),
                "assets/icons/money.svg", PayCash()),
          ],
        ),
      ),
    );
  }

  _paymentMethodCard(
      BuildContext context, String title, String iconPath, Widget nextPage) {
    return GestureDetector(
      onTap: () {
        if (nextPage == null) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(getTranslated(context, 'unsupported'))));
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => nextPage));
        }
      },
      child: Container(
        height: 70.h,
        margin: EdgeInsets.only(bottom: 20.h),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: blue6.withOpacity(.1),
              offset: Offset(0, 1),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 20.w),
            SvgPicture.asset(iconPath),
            SizedBox(width: 20.w),
            Text(
              title,
              style: TextStyle(
                color: accent,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(
              Icons.keyboard_backspace_outlined,
              textDirection: TextDirection.rtl,
            ),
            SizedBox(width: 20.w),
          ],
        ),
      ),
    );
  }
}
