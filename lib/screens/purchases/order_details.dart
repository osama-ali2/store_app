import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yagot_app/models/purchase.dart';
import 'package:yagot_app/screens/purchases/order_tracking.dart';
import 'package:yagot_app/screens/shared/app_button.dart';
import 'package:yagot_app/utilities/helper_functions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDetails extends StatelessWidget {
  final Purchase purchase;

  OrderDetails(this.purchase);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _bodyContent(context),
    );
  }

  Widget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text(getTranslated(context, "order_details")),
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
    );
  }

  Widget _bodyContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Spacer(flex: 5),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _topText(context, "order_number", purchase.orderNo),
              _topText(context, "order_date", purchase.dateTime),
              _topText(context, "order_price", purchase.totalPrice.toString()),
            ],
          ),
        ),
        Spacer(flex: 2),
        _divider(),
        Container(
          height: 100,
          padding: EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset("assets/icons/wallet.svg"),
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getTranslated(context, "payment_details"),
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16.sp,
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(width: 15),
                      Image.asset("assets/images/shipping_company.png"),
                      SizedBox(width: 30),
                      Text(
                        "1234  ****",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
        _divider(),
        Container(
          height: 100,
          padding: EdgeInsetsDirectional.only(
              start: 20, end: 40, top: 20, bottom: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                "assets/icons/truck.svg",
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getTranslated(context, "shipping_details"),
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16.sp,
                    ),
                  ),
                  Text(
                    "شركة ألماس للشحن السريع",
                    style: TextStyle(
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Icon(
                    CupertinoIcons.forward
                  )),
            ],
          ),
        ),
        Container(
          height: 140,
          padding: EdgeInsetsDirectional.only(
              start: 20, end: 40, top: 20, bottom: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                "assets/icons/box.svg",
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getTranslated(context, "delivery_address"),
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16.sp,
                    ),
                  ),
                  Text(
                    "مجمود قمر",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 12.sp
                    ),
                  ),
                  Text("جدة، حي السلام، شارع الرحمة، منزل رقم 20"),
                ],
              ),
              Spacer(),
              Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Icon(
                    CupertinoIcons.forward
                  )),
            ],
          ),
        ),
        Spacer(flex: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: AppButton(
            title: "order_tracking",
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return OrderTracking(purchase);
                  },
                ),
              );
            },
          ),
        ),
        Spacer(flex: 5),
      ],
    );
  }

  Widget _divider() {
    return Container(
      color: Color(0xFFC5CAD4).withOpacity(.7),
      height: .5,
      margin: EdgeInsets.symmetric(horizontal: 30),
    );
  }

  Widget _topText(BuildContext context, String title, String info) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: getTranslated(context, title) + ": ",
          ),
          TextSpan(
            text: info,
            style: TextStyle(fontWeight: FontWeight.bold, height: 1.8),
          ),
        ],
      ),
    );
  }
}
