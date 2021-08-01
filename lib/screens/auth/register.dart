import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:yagot_app/models/product/product.dart';
import 'package:yagot_app/models/settings/InformationModel.dart';
import 'package:yagot_app/models/settings/settings_model.dart';
import 'package:yagot_app/screens/shared/app_button.dart';
import 'package:yagot_app/screens/auth/phone_verify.dart';
import 'package:yagot_app/screens/others/info_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yagot_app/utilities/helper_functions.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:yagot_app/utilities/none_glow_scroll_behavior.dart';
import 'package:yagot_app/providers/general_provider.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:yagot_app/models/LoginRegister/login_details_model.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController userNameCtr,
      emailCtr,
      phoneCtr,
      passwordCtr,
      confirmPasswordCtr;
  String userName, email, phone, password, confirmPassword;
  FocusNode node1, node2, node3, node4, node5, node6, node7;
  bool obscurePassword = true;
  bool obscureConPassword = true;
  final _formKey = GlobalKey<FormState>();
  int countryValue, zoneValue;

  @override
  void initState() {
    super.initState();
    userNameCtr = TextEditingController();
    emailCtr = TextEditingController();
    phoneCtr = TextEditingController();
    passwordCtr = TextEditingController();
    confirmPasswordCtr = TextEditingController();
    node1 = FocusNode();
    node2 = FocusNode();
    node3 = FocusNode();
    node4 = FocusNode();
    node5 = FocusNode();
    node6 = FocusNode();
    node7 = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    userNameCtr.dispose();
    emailCtr.dispose();
    phoneCtr.dispose();
    passwordCtr.dispose();
    confirmPasswordCtr.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(child: _bodyContent(context)),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      brightness: Brightness.light,
      title: Text(
        getTranslated(context, "create_new_account"),
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

  Widget _bodyContent(BuildContext context) {
    return ScrollConfiguration(
      behavior: NoneGlowScrollBehavior(),
      child: Form(
        key: _formKey,
        child: Consumer<GeneralProvider>(
          builder: (context, provider, child) {
            return ListView(
              children: [
                _subtitle('user_name'),
                SizedBox(height: 10.h),
                _textField("user_name", "user_name_error_message", userNameCtr,
                    Fields.USER_NAME, node1, node2),
                SizedBox(height: 20.h),
                _subtitle('email'),
                SizedBox(height: 10.h),
                _textField("email", "empty_email_error_message", emailCtr,
                    Fields.EMAIL, node2, node3),
                SizedBox(height: 20.h),
                _subtitle('phone'),
                SizedBox(height: 10.h),
                _phoneField(),
                SizedBox(height: 20.h),
                _subtitle("country"),
                SizedBox(height: 10.h),
                _dropDownButton("choose_country", true, node4, node5, provider),
                SizedBox(height: 20.h),
                _subtitle("city"),
                SizedBox(height: 10.h),
                _dropDownButton("choose_city", false, node5, node6, provider),
                SizedBox(height: 20.h),
                _subtitle('password'),
                SizedBox(height: 10.h),
                _textField("password", "password_error_message", passwordCtr,
                    Fields.PASSWORD, node6, node7),
                SizedBox(height: 20.h),
                _subtitle('confirm_password'),
                SizedBox(height: 10.h),
                _textField("confirm_password", "password_error_message",
                    confirmPasswordCtr, Fields.CONFIRM_PASSWORD, node7, null),
                SizedBox(height: 40.h),
                _text(context),
                _pressedText(context, provider.settingsModel.policyPrivacy),
                SizedBox(height: 40.h),
                AppButton(
                  title: "create_new_account",
                  onPressed: () {
                    userName = userNameCtr.text;
                    email = emailCtr.text;
                    phone = phoneCtr.text.trim();
                    password = passwordCtr.text;
                    confirmPassword = confirmPasswordCtr.text;
                    int countryId =
                        provider.settingsModel.countries[countryValue].id;
                    String countryCode = provider
                        .settingsModel.countries[countryValue].countryCode;
                    int zoneId = provider.settingsModel.zones[zoneValue].id;
                    String fcmToken = '';
                    if (_formKey.currentState.validate()) {
                      Map<String, String> data = {
                        'name': userName,
                        'country_id': countryId.toString(),
                        'zone_id': zoneId.toString(),
                        'mobile': phone,
                        'password': password,
                        'cpassword': confirmPassword,
                        'country_code': countryCode,
                        'fcm_token': fcmToken,
                        'email': email
                      };
                      print(data);
                      LoginDataModel loginData = provider.singUp(data);
                      if (loginData != null) {
                        print(loginData.token);
                      }
                    }
                  },
                ),
                SizedBox(height: 40.h),
                _loginText(),
              ],
              padding: EdgeInsets.only(
                  top: 40.h, bottom: 120.h, right: 30.w, left: 30.w),
            );
          },
        ),
      ),
    );
  }

  InternationalPhoneNumberInput _phoneField() {
    return InternationalPhoneNumberInput(
      onInputChanged: null,
      textFieldController: phoneCtr,
      validator: (input) {
        int n = int.tryParse(input);
        if (input.isEmpty || input.trim().length < 9 || n == null) {
          return getTranslated(context, "phone_error_message");
        }
        return null;
      },
      onFieldSubmitted: (input) {
        FocusScope.of(context).requestFocus(node4);
      },
      keyboardAction: TextInputAction.next,
      focusNode: node3,
      formatInput: true,
      ignoreBlank: true,
      inputDecoration: _decoration("phone_hint"),
      maxLength: 11,
      countries: ["SA"],
    );
  }

  Widget _subtitle(String textKey) {
    return Text(getTranslated(context, textKey));
  }

  InputDecoration _decoration(String hintKey) {
    return InputDecoration(
      hintText: getTranslated(context, hintKey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.h),
        borderSide: BorderSide(color: accent.withOpacity(.2), width: 1),
      ),
    );
  }

  _textField(String hintKey, String errorKey, TextEditingController controller,
      Fields field, FocusNode node, FocusNode nextNode) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        TextFormField(
          controller: controller,
          obscureText: (field == Fields.PASSWORD)
              ? obscurePassword
              : (field == Fields.CONFIRM_PASSWORD)
                  ? obscureConPassword
                  : false,
          decoration: _decoration(hintKey),
          focusNode: node,
          onFieldSubmitted: (input) {
            if (field == Fields.CONFIRM_PASSWORD) {
              FocusScope.of(context).unfocus();
            } else {
              FocusScope.of(context).requestFocus(nextNode);
            }
          },
          textInputAction: (field == Fields.CONFIRM_PASSWORD)
              ? TextInputAction.done
              : TextInputAction.next,
          keyboardType: (field == Fields.EMAIL)
              ? TextInputType.emailAddress
              : TextInputType.text,
          validator: (input) {
            if (input.isEmpty) {
              return getTranslated(context, errorKey);
            }
            if (field == Fields.EMAIL && !EmailValidator.validate(input)) {
              return getTranslated(context, "invalid_email_error_message");
            }
            if (field == Fields.CONFIRM_PASSWORD &&
                password != confirmPassword) {
              return getTranslated(context, "password_is_not_identical");
            }
            return null;
          },
        ),
        (field == Fields.PASSWORD || field == Fields.CONFIRM_PASSWORD)
            ? IconButton(
                splashRadius: 20,
                onPressed: () {
                  setState(() {
                    field == Fields.PASSWORD
                        ? obscurePassword = !obscurePassword
                        : obscureConPassword = !obscureConPassword;
                  });
                },
                icon: Icon(
                  field == Fields.PASSWORD
                      ? (obscurePassword)
                          ? Icons.visibility
                          : Icons.visibility_off
                      : (obscureConPassword)
                          ? Icons.visibility
                          : Icons.visibility_off,
                ),
                padding: EdgeInsets.symmetric(vertical: 15.h),
              )
            : Container(),
      ],
    );
  }

  Widget _dropDownButton(String hintKey, bool isCountry, FocusNode node,
      FocusNode nextNode, GeneralProvider provider) {
    return DropdownButtonFormField(
      items:
          _buildDropDownItems(isCountry ? provider.countries : provider.zones),
      focusNode: node,
      onChanged: (value) {
        FocusScope.of(context).requestFocus(nextNode);

        isCountry ? countryValue = value : zoneValue = value;
      },
      iconEnabledColor: primary,
      value: isCountry ? countryValue : zoneValue,
      isExpanded: true,
      decoration: _decoration(hintKey),
      validator: (value) {
        if (value == null) {
          return getTranslated(context, hintKey);
        }
        return null;
      },
    );
  }

  List<DropdownMenuItem> _buildDropDownItems(List<String> choices) {
    return choices.map((choice) {
      return DropdownMenuItem(
        child: Text(choice),
        value: choices.indexOf(choice),
      );
    }).toList();
  }

  Widget _text(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Text(
          getTranslated(context, "by_using_yagot"),
          style: TextStyle(
            color: accent,
            fontSize: 12.sp,
            fontWeight: FontWeight.w100,
          ),
        ));
  }

  Widget _pressedText(BuildContext context, InformationModel info) {
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return InfoPage(info: info);
          }));
        },
        child: Text(
          getTranslated(context, "content_security_policy"),
          style: TextStyle(
              color: blue5,
              fontSize: 11.sp,
              fontFamily: "NeoSansArabic",
              decoration: TextDecoration.underline),
        ),
      ),
    );
  }

  Widget _loginText() {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Align(
        alignment: Alignment.center,
        child: Text(
          getTranslated(context, "login"),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

enum Fields {
  USER_NAME,
  EMAIL,
  PASSWORD,
  CONFIRM_PASSWORD,
}
