import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:yagot_app/models/product/product.dart';
import 'package:yagot_app/models/product/product_details.dart';
import 'package:yagot_app/utilities/custom_icons.dart';
import 'package:yagot_app/utilities/helper_functions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<ProductModel> products = [
    ProductModel(
        details: ProductDetails(
            title: 'خاتم ألماس حر',
            price: '500',
            currencyName: '\$',
            dateTime: '‏10 أغسطس، 2020',
            image: 'assets/images/product1.png'))
  ];
  bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _bodyContent(),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: white,
      brightness: Brightness.light,
      title: Text(
        getTranslated(context, "search"),
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
      padding: EdgeInsets.only(top: 30.h, left: 30.w, right: 30.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getTranslated(context, "what_product_are_you_search_for"),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 20.h),
          _searchPlace(),
          SizedBox(height: 20),
          (products != null && products.isNotEmpty)
              ? _resultsCount()
              : Container(),
          SizedBox(height: 20.h),
          !isEmpty ? _searchResults() : Container(),
          _emptyResults(),
        ],
      ),
    );
  }

  Widget _resultsCount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          getTranslated(context, "search_results"),
        ),
        Text(getTranslated(context, "item") + " " + products.length.toString())
      ],
    );
  }

  Expanded _searchResults() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, position) {
          ProductModel currentProduct = products[position];
          return Container(
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: [
                BoxShadow(
                  color: accent.withOpacity(.06),
                  offset: Offset(0, 3),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  currentProduct.details.image,
                  width: 80.w,
                  height: 80.h,
                  fit: BoxFit.cover,
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
                    SizedBox(height: 12.h),
                    Text(
                      currentProduct.details.dateTime,
                      style: TextStyle(
                        color: grey2,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
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
        padding: EdgeInsets.only(bottom: 60.h),
      ),
    );
  }

  Widget _searchPlace() {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: accent.withOpacity(.20),
            width: 1,
          ),
        ),
        prefixIcon: Icon(
          CustomIcons.search,
          color: accent,
        ),
        hintText: getTranslated(context, "search_here"),
      ),
      textInputAction: TextInputAction.search,
      onSubmitted: (value) {
        setState(() {
          products = [];
          isEmpty = true;
        });
      },
    );
  }

  Widget _emptyResults() {
    return AnimatedOpacity(
      opacity: isEmpty ? 1 : 0,
      duration: Duration(milliseconds: 500),
      child: Align(
        alignment: AlignmentDirectional.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 60.h),
            SvgPicture.asset("assets/icons/empty_search.svg"),
            SizedBox(height: 60.h),
            Text(
              getTranslated(context, "no_similar_search_results"),
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              width: 200.w,
              child: Text(
                getTranslated(context, "you_can_search_another_time"),
                textAlign: TextAlign.center,
                style: TextStyle(height: 1.5),
              ),
            )
          ],
        ),
      ),
    );
  }
}
