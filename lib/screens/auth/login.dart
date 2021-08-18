import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:yagot_app/providers/general_provider.dart';
import 'package:yagot_app/screens/auth/register.dart';
import 'package:yagot_app/screens/common/widgets/app_button.dart';
import 'package:yagot_app/screens/common/widgets/app_text_field.dart';
import 'package:yagot_app/screens/main/main_page_view.dart';
import 'package:yagot_app/utilities/enums.dart';
import 'package:yagot_app/utilities/helper_functions.dart';

class LoginScreen extends StatefulWidget {
  final Pages page;

  LoginScreen({this.page});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _username;
  TextEditingController _password;
  bool _obscurePassword = true;
  FocusNode _node1;
  FocusNode _node2;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _username = TextEditingController();
    _password = TextEditingController();
    _node1 = FocusNode();
    _node2 = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _username.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text(
          getTranslated(context, "login"),
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
      body: SafeArea(child: _bodyContent(context)),
    );
  }

  Widget _bodyContent(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 70.h, right: 30.w, left: 30.w),
      children: [
        _topImage(),
        SizedBox(height: 40.h),
        _loginForm(),
        SizedBox(height: 16.h),
        _forgetPasswordText(),
        SizedBox(height: 25.h),
        AppButton(
          title: 'login',
          loading: loading,
          onPressed: () {
            if (_formKey.currentState.validate()) {
              final data = {
                'mobile': _username.text,
                'password': _password.text
              };
              setState(() {
                loading = true;
              });
              context.read<GeneralProvider>().login(context, data, () {
                setState(() {
                  loading = false;
                });
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => MainPages()),
                    (route) => false);
              }, () {
                setState(() {
                  loading = false;
                });
              });
            }
          },
        ),
        SizedBox(height: 30.h),
        _createAccountText(),
      ],
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
          AppTextField(
            hintKey: 'user_name',
            errorKey: 'user_name_error_message',
            controller: _username,
            node: _node1,
            nextNode: _node2,
          ),
          SizedBox(height: 20.h),
          _fieldTitleText(getTranslated(context, "password")),
          SizedBox(height: 8.h),
          AppTextField(
            hintKey: 'password',
            errorKey: 'password_error_message',
            controller: _password,
            node: _node2,
            nextNode: null,
            isObscured: _obscurePassword,
          ),
        ],
      ),
    );
  }

  Widget _fieldTitleText(String title) {
    return Text(
      title,
      style: TextStyle(
          color: accent, fontSize: 14.sp, fontWeight: FontWeight.normal),
    );
  }

  InputDecoration _fieldDecoration(String hint) {
    return InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
      hintText: hint,
      hintStyle: TextStyle(
          color: grey1, fontSize: 12.sp, fontWeight: FontWeight.normal),
    );
  }

  Widget _forgetPasswordText() {
    return GestureDetector(
      onTap: () {
        //todo: go to forget password page
      },
      child: Text(getTranslated(context, "forget_password"),
          style: TextStyle(
            fontSize: 12.sp,
          ),
          textAlign: TextAlign.end),
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
          padding: EdgeInsets.all(8.r),
          child: Text(
            getTranslated(context, "create_new_account"),
          ),
        ),
      ),
    );
  }
}
