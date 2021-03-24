import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:yagot_app/screens/sign_login/register.dart';
import 'package:yagot_app/utilities/helper_functions.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:provider/provider.dart';
import 'package:yagot_app/providers/general_provider.dart';
import 'package:yagot_app/models/LoginRegister/login_details_model.dart';
import 'package:yagot_app/screens/main/main_page_view.dart';
import 'package:yagot_app/singleton/dio.dart';
import 'package:yagot_app/singleton/AppSP.dart';
import 'package:yagot_app/screens/main/home.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _userNameTextController;
  TextEditingController _passwordTextController;
  String userName;
  String password;
  bool _obscurePassword = true;
  FocusNode _node1;

  @override
  void initState() {
    super.initState();
    _userNameTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _node1 = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _userNameTextController.dispose();
    _passwordTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text(
          getTranslated(context, "login"),
          style: TextStyle(
            color: blue1,
            fontFamily: "NeoSansArabic",
            fontWeight: FontWeight.bold,
            fontSize: 16.ssp,
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
      body: SafeArea(child: _bodyContent(context)),
    );
  }

  Widget _bodyContent(BuildContext context) {
    return Consumer<GeneralProvider>(
      builder: (context, value, child) {
        LoginDataModel _loginData = value.loginData;
        if (_loginData != null && _loginData.token != null && _loginData.token.isNotEmpty) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MainPages()),
                    (route) => false);
          });
        }
        return ListView(
          padding: EdgeInsets.only(top: 70.h, right: 30.w, left: 30.w),
          physics: BouncingScrollPhysics(),
          children: [
            _topImage(),
            SizedBox(height: 40.h),
            _loginForm(),
            SizedBox(height: 16.h),
            _forgetPasswordText(),
            SizedBox(height: 25.h),
            _loginButton(),
            SizedBox(height: 30.h),
            _createAccountText(),
          ],
        );
      },
    );
  }

  Widget _topImage() {
    return SvgPicture.asset(
      "assets/icons/full_logo.svg",
      height: 120.h,
      width: 130.w,
    );
  }

  Widget _loginForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _fieldTitleText(getTranslated(context, "user_name")),
          SizedBox(height: 8.h),
          _userNameField(),
          SizedBox(height: 20.h),
          _fieldTitleText(getTranslated(context, "password")),
          SizedBox(height: 8.h),
          _passwordField(),
        ],
      ),
    );
  }

  Widget _fieldTitleText(String title) {
    return Text(
      title,
      style: TextStyle(
          color: blue1,
          fontSize: 14.ssp,
          fontFamily: "NeoSansArabic",
          fontWeight: FontWeight.normal),
    );
  }

  InputDecoration _fieldDecoration(String hint) {
    return InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      hintText: hint,
      hintStyle: TextStyle(
          color: grey1, fontSize: 12.ssp, fontWeight: FontWeight.normal),
    );
  }

  Widget _userNameField() {
    return TextFormField(
      controller: _userNameTextController,
      validator: (input) {
        if (input.isEmpty) {
          return getTranslated(context, "user_name_error_message");
        }
        return null;
      },
      decoration: _fieldDecoration(getTranslated(context, "user_name")),
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (input) {
        FocusScope.of(context).requestFocus(_node1);
      },
    );
  }

  Widget _passwordField() {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        TextFormField(
          obscureText: _obscurePassword,
          controller: _passwordTextController,
          validator: (input) {
            if (input.isEmpty) {
              return getTranslated(context, "password_error_message");
            }
            return null;
          },
          decoration: _fieldDecoration(getTranslated(context, "password")),
          textInputAction: TextInputAction.done,
          focusNode: _node1,
          onFieldSubmitted: (input) {
            FocusScope.of(context).unfocus();
          },
        ),
        IconButton(
          splashRadius: 20.w,
          onPressed: () {
            // setState(() {
            //   _obscurePassword = !_obscurePassword;
            // });
          },
          icon: Icon(
              (_obscurePassword) ? Icons.visibility : Icons.visibility_off),
          padding: EdgeInsets.symmetric(vertical: 15.h),
        ),
      ],
    );
  }

  Widget _forgetPasswordText() {
    return GestureDetector(
      onTap: () {
        //todo: go to forget password page
      },
      child: Text(getTranslated(context, "forget_password"),
          style: TextStyle(
            fontSize: 12.ssp,
          ),
          textAlign: TextAlign.end),
    );
  }

  Widget _loginButton() {
    return SizedBox(
      height: 50.h,
      child: FlatButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            final data = {
              'mobile': _userNameTextController.text,
              'password': _passwordTextController.text
            };
            Provider.of<GeneralProvider>(context, listen: false).login(data);
          }
        },
        color: primary,
        child: Text(
          getTranslated(context, "login"),
          style: TextStyle(color: white, fontFamily: "NeoSansArabic"),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.w),
        ),
      ),
    );
  }

  Widget _createAccountText() {
    return Align(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return Register();
            }),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(8.h),
          child: Text(
            getTranslated(context, "create_new_account"),
          ),
        ),
      ),
    );
  }
}
