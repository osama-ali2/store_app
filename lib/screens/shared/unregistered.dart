import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yagot_app/screens/add_product/using_policy.dart';
import 'package:yagot_app/screens/sign_login/login.dart';
import 'package:yagot_app/screens/sign_login/register.dart';
import 'package:yagot_app/utilities/helper_functions.dart';

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
      backgroundColor: Colors.transparent,
      title: Text(
        getTranslated(context,
            (page == Pages.ADD_PRODUCTS) ? "add_new_product" : "notifications"),
      ),
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

  _bodyContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Spacer(flex: 2),
        SvgPicture.asset((page == Pages.ADD_PRODUCTS)
            ? "assets/icons/unregistered_add_product.svg"
            : "assets/icons/empty_not.svg"),
        Spacer(flex: 1),
        Text(
          getTranslated(context, "you_are_not_registered"),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        Text(
          getTranslated(
              context,
              (page == Pages.ADD_PRODUCTS)
                  ? "register_to_add_new_product"
                  : "register_to_see_notifications"),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
        ),
        Spacer(flex: 1),
        _loginButton(context),
        Spacer(flex: 1),
        _createAccountText(context),
        Spacer(flex: 4),
      ],
    );
  }

  Widget _loginButton(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xFF00041D).withOpacity(.16),
            offset: Offset(0, 3),
            blurRadius: 6,
          )
        ],
      ),
      child: RaisedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return LoginScreen();
              },
            ),
          );
        },
        child: Text(
          getTranslated(context, "login"),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
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
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _userKind(BuildContext context) {
    return Container(
      height: 300,
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.black,
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
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(flex: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  UsingPolicy(isCompany: false);
                },
                child: Container(
                  height: 135,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF1F4282).withOpacity(.16),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        ),
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SvgPicture.asset("assets/icons/user.svg"),
                      ),
                      SizedBox(height: 22),
                      Text(
                        getTranslated(context, "hobbyist"),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(width: 16),
              GestureDetector(
                onTap: () {
                  UsingPolicy(isCompany: true);
                },
                child: Container(
                  height: 135,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Color(0xFF595B67),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xFF595B67),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SvgPicture.asset("assets/icons/company.svg"),
                      ),
                      SizedBox(height: 22),
                      Text(
                        getTranslated(context, "company"),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF595B67),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }
}

enum Pages {
  NOTIFICATIONS,
  ADD_PRODUCTS,
}
