import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:yagot_app/models/product/product.dart';
import 'package:yagot_app/utilities/helper_functions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserAds extends StatefulWidget {
  @override
  _UserAdsState createState() => _UserAdsState();
}

class _UserAdsState extends State<UserAds> with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<ProductModel> products ;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: transparent,
        title: Text(getTranslated(context, "my_ads")),
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
      children: [
        SizedBox(height: 30),
        _bubbleTabBar(),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _itemsList(products),
              _itemsList(products),
              _itemsList(products),
            ],
          ),
        ),
      ],
    );
  }

  Widget _itemsList(List<ProductModel> products) {
    return ListView.builder(
      itemBuilder: (context, position) {
        ProductModel currentProduct = products[position];
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: white,
              boxShadow: [
                BoxShadow(
                    color: accent.withOpacity(.06),
                    offset: Offset(0, 3),
                    blurRadius: 6,
                    spreadRadius: 2)
              ]),
          clipBehavior: Clip.hardEdge,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: ExactAssetImage(currentProduct.details.image),
                      fit: BoxFit.cover),
                ),
              ),
              Spacer(flex: 1),
              Column(
                children: [
                  Text(
                    currentProduct.details.title,
                    style: TextStyle(
                      color: accent,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 12),
                  // Text(
                  //   currentProduct.dateTime,
                  //   style: TextStyle(
                  //           color: grey2,
                  //           fontSize: 12.sp,
                  //           fontWeight: FontWeight.normal,
                  //         ),,
                  // ),
                ],
              ),
              Spacer(flex: 4),
              Text(
                currentProduct.details.price,
                style: TextStyle(
                  color: grey2,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                ),
              ),
              Spacer(flex: 1),
            ],
          ),
        );
      },
      itemCount: products.length,
      padding: EdgeInsets.all(30.r),
    );
  }

  Widget _bubbleTabBar() {
    return Stack(
      alignment: Alignment.center,
      children: [
        _tabBackground(),
        _tabItems(),
      ],
    );
  }

  Widget _tabBackground() {
    return Container(
      width: 315,
      height: 50,
      decoration: BoxDecoration(
          color: grey8, borderRadius: BorderRadius.circular(25.r),
      boxShadow: [BoxShadow(
        color: primary.withOpacity(.16),
        offset: Offset(0, 2),
        blurRadius: 4,
      ),],),
    );
  }

  Widget _tabItems() {
    return SizedBox(
      width: 322,
      child: TabBar(
        controller: _tabController,
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
          Text(getTranslated(context, "pending")),
          Text(getTranslated(context, "locked")),
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
