// import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:yagot_app/constants/colors.dart';

import 'package:yagot_app/screens/common/widgets/app_button.dart';
import 'package:yagot_app/screens/shipping_address/addresses.dart';
import 'package:yagot_app/utilities/custom_icons.dart';
import 'package:yagot_app/utilities/helper_functions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShippingScreen extends StatefulWidget {
  @override
  _ShippingScreenState createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _sPosition = -1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        brightness: Brightness.light,
        title: Text(
          getTranslated(context, "shipping_companies"),
          style: TextStyle(
            color: accent,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
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
      body: _bodyContent(context),
    );
  }

  _bodyContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 40.h),
        Padding(
          padding: EdgeInsetsDirectional.only(start: 30.w),
          child: Text(
            getTranslated(context, "choose_shipping_method"),
            style: TextStyle(
              color: accent,
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
            ),
          ),
        ),
        SizedBox(height: 30.h),
        Container(
          width: MediaQuery.of(context).size.width,
          child: TabBar(
            labelStyle: TextStyle(
              color: white,
              fontSize: 12.sp,
            ),
            controller: _tabController,
            unselectedLabelColor: grey2,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r), color: primary),
            tabs: [
              Tab(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.r),
                    border: Border.all(color: grey2, width: 1),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CustomIcons.truck,
                          size: 20,
                        ),
                        SizedBox(width: 20.w),
                        Text(getTranslated(context, "shipping_company")),
                      ],
                    ),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(color: grey2, width: 1)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(CustomIcons.order),
                        SizedBox(width: 12.w),
                        Text(getTranslated(context, "manual_delivery")),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 60.h),
        _tabView(),
      ],
    );
  }

  _companyCard(int position) {
    return Container(
      height: 80.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      margin: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(12.r),
        border:
            Border.all(color: primary, width: _sPosition == position ? 1 : 0),
        boxShadow: [
          BoxShadow(
            color: blue6.withOpacity(.1),
            offset: Offset(0, 1),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // CircularCheckBox(
          //   onChanged: (value) {
          //     setState(() {
          //       _sPosition = position;
          //     });
          //   },
          //   value: _sPosition == position,
          //   activeColor: primary,
          // ),
          Spacer(flex: 1),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'shippingCompany.name',
                style: TextStyle(
                  color: accent,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "الوصول يوم 19/2/2021",
                style: TextStyle(
                  color: grey2,
                  fontWeight: FontWeight.w200,
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),
          Spacer(flex: 6),
          Container(
            height: 16.h,
            width: 55.w,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: ExactAssetImage('assets/images/shipping_company.png'),
                  fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }

  _tabView() {
    return Expanded(
      child: TabBarView(controller: _tabController, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(start: 30.w, bottom: 30.h),
              child: Text(
                getTranslated(context, "choose_shipping_company"),
                style: TextStyle(
                  color: accent,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, position) {
                  return _companyCard(position);
                },
                itemCount: 5,
                padding: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 30.h),
              ),
            ),
            AnimatedOpacity(
                opacity: _sPosition == -1 ? 0 : 1,
                duration: Duration(milliseconds: 500),
                child: _button())
          ],
        ),
        _button(),
      ]),
    );
  }

  _button() {
    return Align(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: AppButton(
        title: 'continue',
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddressesScreen(),
              ));
        },
      ),
    ));
  }
}
