import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:yagot_app/screens/add_product/using_policy.dart';
import 'package:yagot_app/screens/auth/login.dart';
import 'package:yagot_app/screens/auth/register.dart';
import 'package:yagot_app/screens/common/widgets/app_button.dart';
import 'package:yagot_app/utilities/enums.dart';
import 'package:yagot_app/utilities/helper_functions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Unregistered extends StatelessWidget {
  final Pages page;

  Unregistered({this.page});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _bodyContent(context),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: transparent,
      title: Text(
        getTranslated(context,
            (page == Pages.addProducts) ? "add_new_product" : "notifications"),
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
    );
  }

  _bodyContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Spacer(flex: 2),
        SvgPicture.asset((page == Pages.addProducts)
            ? "assets/icons/unregistered_add_product.svg"
            : "assets/icons/empty_not.svg"),
        Spacer(flex: 1),
        Text(
          getTranslated(context, "you_are_not_registered"),
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          getTranslated(
              context,
              (page == Pages.addProducts)
                  ? "register_to_add_new_product"
                  : "register_to_see_notifications"),
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.normal,
          ),
        ),
        Spacer(flex: 1),
        AppButton(
          title: 'login',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return LoginScreen(page: page);
                },
              ),
            );
          },
          width: 0.9.sw,
        ),
        Spacer(flex: 1),
        _createAccountText(context),
        Spacer(flex: 4),
      ],
    );
  }

  Widget _createAccountText(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return Register();
          }),
        );
      },
      child: Text(
        getTranslated(context, "create_new_account"),
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _userKind(BuildContext context) {
    return Container(
      height: 300.h,
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)),
        boxShadow: [
          BoxShadow(
            color: black,
            offset: Offset(0, 1),
            blurRadius: 3,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Spacer(flex: 3),
          Text(
            getTranslated(context, "are_you"),
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(flex: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              kindBtn(context , 'hobbyist' , 'user.svg'),
              SizedBox(width: 16.w),
              kindBtn(context, 'company', 'company.svg')
            ],
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }

  GestureDetector kindBtn(BuildContext context , String label , iconName) {
    return GestureDetector(
              onTap: () {
                UsingPolicy(isCompany: label.toLowerCase() == 'company');
              },
              child: Container(
                height: 135.h,
                width: 150.w,
                decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: [
                      BoxShadow(
                        color: primary.withOpacity(.16),
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      ),
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 40.r,
                      width: 40.r,
                      padding: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: SvgPicture.asset("assets/icons/$iconName"),
                    ),
                    SizedBox(height: 22.h),
                    Text(
                      getTranslated(context, label),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: white,
                      ),
                    )
                  ],
                ),
              ),
            );
  }
}


