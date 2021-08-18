import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:yagot_app/models/purchase.dart';
import 'package:yagot_app/screens/add_product/bundles.dart';
import 'package:yagot_app/screens/purchases/order_details.dart';
import 'package:yagot_app/screens/common/widgets/app_button.dart';
import 'package:yagot_app/utilities/helper_functions.dart';

class PurchasesScreen extends StatefulWidget {
  @override
  _PurchasesScreenState createState() => _PurchasesScreenState();
}

class _PurchasesScreenState extends State<PurchasesScreen> {
  List<Purchase> purchases  ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: transparent,
        title: Text(getTranslated(context, "my_purchases")),
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
      body: (purchases == null || purchases.isEmpty)
          ? EmptyPurchases()
          : UserPurchases(purchases),
    );
  }
}

class UserPurchases extends StatelessWidget {
  final List<Purchase> purchases;

  UserPurchases(this.purchases);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: _bodyContent(context),
    );
  }

  _bodyContent(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30),
        _bubbleTabBar(context),
        Expanded(
          child: TabBarView(
            children: [
              _itemList(context, purchases),
              _itemList(context, purchases),
            ],
          ),
        ),
      ],
    );
  }

  Widget _itemList(BuildContext context, List<Purchase> purchases) {
    return ListView.builder(
      itemBuilder: (context, position) {
        Purchase currentPurchase = purchases[position];
        return _itemCard(context, currentPurchase);
      },
      padding: EdgeInsets.symmetric(vertical: 40.h ,horizontal: 14.w),
      itemCount: purchases.length,
    );
  }

  Widget _itemCard(BuildContext context, Purchase purchase) {
    TextStyle _lightText = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 10.sp,
    );
    TextStyle _boldText = TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 12.sp,
    );
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return OrderDetails(purchase);
        },),);
      },
      child: Container(
        height: 130,
        margin: EdgeInsets.symmetric(vertical: 10.h),
        padding:  EdgeInsets.only(right: 16.w,left: 16.w , top: 32.h , bottom: 18.h),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: accent.withOpacity(.06),
              offset: Offset(0, 0),
              blurRadius: 16,
              spreadRadius: 2,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              purchase.product.details.image,
              height: 60,
              width: 60,
            ),
            SizedBox(width: 16),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  purchase.product.details.title,
                  style: _boldText,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: getTranslated(context, "order_number") + ":",
                        style: _lightText.copyWith(fontSize: 12.sp),
                      ),
                      TextSpan(
                        text: purchase.orderNo,
                        style: _boldText,
                      ),
                    ],
                  ),
                ),
                Text(
                  getTranslated(context, "total") +
                      ":" +
                      purchase.totalPrice.toString(),
                  style: _lightText
                ),
                Text(
                  purchase.dateTime,
                  style:_lightText
                ),
              ],
            ),
            Spacer(),
            Align(alignment:Alignment.topCenter,child: _statusText(context, purchase)),
          ],
        ),
      ),
    );
  }

  Widget _statusText(BuildContext context , Purchase purchase){
    return Container(
      height: 22,
        width: 54,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: primary.withOpacity(.2),
          borderRadius: BorderRadius.circular(5.r),
        ),
      child: Text(
        purchase.status.toString(),
        style: TextStyle(
          color: primary,
          fontSize: 10.sp,
        ),
      ),
    );
  }

  Widget _bubbleTabBar(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _tabBackground(),
        _tabItems(context),
      ],
    );
  }

  Widget _tabBackground() {
    return Container(
      width: 315,
      height: 50,
      decoration: BoxDecoration(
        color: grey8,
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: primary.withOpacity(.16),
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
    );
  }

  Widget _tabItems(BuildContext context) {
    return SizedBox(
      width: 322,
      child: TabBar(
        labelStyle: TextStyle(
            color: white,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(
            color: accent,
            fontSize: 14.sp,
            fontWeight: FontWeight.normal),
        unselectedLabelColor: accent,
        tabs: [
          Text(getTranslated(context, "enabled")),
          Text(getTranslated(context, "closed")),
        ],
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BubbleTabIndicator(
          indicatorColor: primary,
          indicatorHeight: 50,
          indicatorRadius: 25,
          tabBarIndicatorSize: TabBarIndicatorSize.tab,
        ),
      ),
    );
  }

}

class EmptyPurchases extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Spacer(flex: 2),
        SvgPicture.asset("assets/icons/empty_purchases.svg"),
        Spacer(flex: 1),
        Text(
          getTranslated(context, "no_purchases_currently"),
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        Text(
          getTranslated(context, "you_can_start_shopping"),
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.normal,
          ),
        ),
        Spacer(flex: 1),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 30.w),
          child: AppButton(title: "start_shopping",onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Bundles();
                },
              ),
            );
          },),
        ),
        Spacer(flex: 4),
      ],
    );
  }
}
