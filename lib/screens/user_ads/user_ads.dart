import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:yagot_app/models/product/product.dart';
import 'package:yagot_app/utilities/helper_functions.dart';

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
        backgroundColor: Colors.transparent,
        title: Text(getTranslated(context, "my_ads")),
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
          margin: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Color(0xFF00041D).withOpacity(.06),
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
                      color: Color(0xFF00041D),
                      fontFamily: "NeoSansArabic",
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 12),
                  // Text(
                  //   currentProduct.dateTime,
                  //   style: Theme.of(context).textTheme.headline2,
                  // ),
                ],
              ),
              Spacer(flex: 4),
              Text(
                currentProduct.details.price,
                style: TextStyle(
                  color: Color(0xFF595B67),
                  fontFamily: "NeoSansArabic",
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              Spacer(flex: 1),
            ],
          ),
        );
      },
      itemCount: products.length,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(30),
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
          color: Color(0xFFD6DCE9), borderRadius: BorderRadius.circular(25),
      boxShadow: [BoxShadow(
        color: Color(0xFF1F4282).withOpacity(.16),
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
            color: Colors.white,
            fontSize: 14,
            fontFamily: "NeoSansArabic",
            fontWeight: FontWeight.bold),
        unselectedLabelStyle: Theme.of(context).textTheme.headline3,
        unselectedLabelColor: Color(0xFF00041D),
        tabs: [
          Text(getTranslated(context, "enabled")),
          Text(getTranslated(context, "pending")),
          Text(getTranslated(context, "locked")),
        ],
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BubbleTabIndicator(
          indicatorColor: Theme.of(context).primaryColor,
          indicatorHeight: 50,
          indicatorRadius: 25,
          tabBarIndicatorSize: TabBarIndicatorSize.tab,
        ),
      ),
    );
  }
}
