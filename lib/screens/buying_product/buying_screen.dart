import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:yagot_app/screens/buying_product/payment_methods.dart';
import 'package:yagot_app/screens/common/widgets/app_button.dart';
import 'package:yagot_app/screens/shipping_address/edit_address.dart';
import 'package:yagot_app/screens/shipping_address/shipping_screen.dart';
import 'package:yagot_app/utilities/custom_icons.dart';
import 'package:yagot_app/utilities/helper_functions.dart';

class BuyingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: transparent,
        title: Text(
          getTranslated(context, "payment"),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _productCard(context),
          Spacer(flex: 1),
          _shippingDetails(context),
          _deliveryAddress(context),
          Spacer(flex: 2),
          Container(
            height: MediaQuery.of(context).size.height * .28,
            decoration: BoxDecoration(
              color: white,
              boxShadow: [
                BoxShadow(
                  color: black.withOpacity(.1),
                  blurRadius: 3,
                  offset: Offset(0, -1),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(30.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        getTranslated(context, "amount"),
                        style: TextStyle(
                            color: grey2, fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "160\$",
                        style: TextStyle(
                            color: grey2, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        getTranslated(context, "delivery_price"),
                        style: TextStyle(
                            color: grey2, fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "0\$",
                        style: TextStyle(
                            color: grey2, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        getTranslated(context, "total_amount"),
                        style: TextStyle(
                            color: accent, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "160\$",
                        style: TextStyle(
                            color: accent, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Container(
                    height: MediaQuery.of(context).size.height * .065,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: accent.withOpacity(.16),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        )
                      ],
                    ),
                    child: AppButton(title: 'buy', onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> PaymentMethodsScreen()));
                    },),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _productCard(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .12,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(.06),
            blurRadius: 12,
            offset: Offset(0, 3),
          )
        ],
        color: white,
      ),
      padding: EdgeInsetsDirectional.only(start: 24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
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
          SizedBox(width: 10.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Seller name',
                style: TextStyle(
                    fontSize: 12.sp,
                    color: grey5,
                    fontWeight: FontWeight.normal),
              ),
              Text(
                '160\$',
                style: TextStyle(
                    fontSize: 12.sp,
                    color: blue6,
                    fontWeight: FontWeight.w600),
              )
            ],
          )
        ],
      ),
    );
  }

  _shippingDetails(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ShippingScreen()));
      },
      child: Container(
        height: MediaQuery.of(context).size.height * .12,
        alignment: Alignment.center,
        color: white,
        padding: EdgeInsetsDirectional.fromSTEB(20.w, 10.h, 40.w, 10.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  CustomIcons.truck,
                  size: 18,
                  color: primary,
                ),
                SizedBox(
                  width: 20.w,
                ),
                Text.rich(
                  TextSpan(
                    text:
                            getTranslated(context,"shipping_details") +
                        "\n",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: accent,
                    ),
                    children: [
                      TextSpan(
                        text: "شركة الماس للشحن السريع",
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.normal,
                            color: grey2,
                            height: 3),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Spacer(),
            Icon(
              Icons.arrow_back_ios_rounded,
              color:accent,
              size: 16,
              textDirection: TextDirection.rtl,
            )
          ],
        ),
      ),
    );
  }

  _deliveryAddress(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>EditAddress()));
      },
      child: Container(
        height: MediaQuery.of(context).size.height * .17,
        alignment: Alignment.center,
        color:white,
        padding: EdgeInsetsDirectional.fromSTEB(20.w ,10.h, 40.w, 10.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  CustomIcons.box,
                  size: 20,
                  color: primary,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text.rich(
                  TextSpan(
                    text:
                            getTranslated(context,"delivery_address") +
                        "\n",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: accent,
                    ),
                    children: [
                      TextSpan(
                        text: "محمود قمر" + "\n",
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: accent,
                            height: 3),
                      ),
                      TextSpan(
                        text: "جدة.حي السلام.شارع الرحمة.منزل رقم 20",
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.normal,
                            color:grey2,
                            height: 3),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Spacer(),
            Icon(
              Icons.arrow_back_ios_rounded,
              color: accent,
              size: 16,
              textDirection: TextDirection.rtl,
            )
          ],
        ),
      ),
    );
  }
}
