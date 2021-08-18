import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:yagot_app/models/settings/InformationModel.dart';
import 'package:yagot_app/providers/general_provider.dart';
import 'package:yagot_app/screens/common/widgets/app_button.dart';
import 'package:yagot_app/screens/common/widgets/app_text_field.dart';
import 'package:yagot_app/screens/others/info_page.dart';
import 'package:yagot_app/utilities/field_decoration.dart';
import 'package:yagot_app/utilities/helper_functions.dart';
import 'package:yagot_app/utilities/none_glow_scroll_behavior.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _username, _email, _phone, _password, _cPassword;
  FocusNode node1, node2, node3, node4, node5, node6, node7;
  bool obscurePassword = true;
  bool obscureCPassword = true;
  final _formKey = GlobalKey<FormState>();
  int countryValue, zoneValue;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _username = TextEditingController();
    _email = TextEditingController();
    _phone = TextEditingController();
    _password = TextEditingController();
    _cPassword = TextEditingController();
    node1 = FocusNode();
    node2 = FocusNode();
    node3 = FocusNode();
    node4 = FocusNode();
    node5 = FocusNode();
    node6 = FocusNode();
    node7 = FocusNode();
    context.read<GeneralProvider>().getSettings(context, () {}, () {});
  }

  @override
  void dispose() {
    super.dispose();
    _username.dispose();
    _email.dispose();
    _phone.dispose();
    _password.dispose();
    _cPassword.dispose();
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
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    top: 40.h, bottom: 120.h, right: 30.w, left: 30.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _subtitle('user_name'),
                    SizedBox(height: 10.h),
                    AppTextField(
                      hintKey: 'user_name',
                      errorKey: 'user_name_error_message',
                      controller: _username,
                      node: node1,
                      nextNode: node2,
                    ),
                    SizedBox(height: 20.h),
                    _subtitle('email'),
                    SizedBox(height: 10.h),
                    AppTextField(
                      hintKey: 'email',
                      errorKey: 'empty_email_error_message',
                      controller: _email,
                      node: node2,
                      nextNode: node3,
                    ),
                    SizedBox(height: 20.h),
                    _subtitle('phone'),
                    SizedBox(height: 10.h),
                    _phoneField(),
                    SizedBox(height: 20.h),
                    _subtitle("country"),
                    SizedBox(height: 10.h),
                    _dropDownButton(
                        "choose_country", true, node4, node5, provider),
                    SizedBox(height: 20.h),
                    _subtitle("city"),
                    SizedBox(height: 10.h),
                    _dropDownButton(
                        "choose_city", false, node5, node6, provider),
                    SizedBox(height: 20.h),
                    _subtitle('password'),
                    SizedBox(height: 10.h),
                    AppTextField(
                      hintKey: 'password',
                      errorKey: 'password_error_message',
                      controller: _password,
                      node: node6,
                      nextNode: node7,
                      isObscured: obscurePassword,
                    ),
                    SizedBox(height: 20.h),
                    _subtitle('confirm_password'),
                    SizedBox(height: 10.h),
                    AppTextField(
                      hintKey: 'confirm_password',
                      errorKey: 'password_error_message',
                      controller: _cPassword,
                      node: node7,
                      nextNode: null,
                      isObscured: obscureCPassword,
                    ),
                    SizedBox(height: 40.h),
                    _text(context),
                    _pressedText(context, provider.policyPrivacy),
                    SizedBox(height: 40.h),
                    AppButton(
                      title: "create_new_account",
                      loading: loading,
                      onPressed: () {

                        if (_formKey.currentState.validate()) {
                          int countryId = provider.countries[countryValue].id;
                          String countryCode =
                              provider.countries[countryValue].countryCode;
                          int zoneId = provider.zones[zoneValue].id;
                          String fcmToken = '';
                          Map<String, String> data = {
                            'name': _username.text,
                            'country_id': countryId.toString(),
                            'zone_id': zoneId.toString(),
                            'mobile': _phone.text,
                            'password': _password.text,
                            'cpassword': _cPassword.text,
                            'country_code': countryCode,
                            'fcm_token': fcmToken,
                            'email': _email.text,
                          };
                          print(data);
                          setState(() {
                            loading = true;
                          });
                          provider.singUp(context, data, () {
                            setState(() {
                              loading = false;
                            });
                          }, () {
                            setState(() {
                              loading = false;
                            });
                          });
                        }
                      },
                    ),
                    SizedBox(height: 40.h),
                    _loginText(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  InternationalPhoneNumberInput _phoneField() {
    return InternationalPhoneNumberInput(
      onInputChanged: null,
      textFieldController: _phone,
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
      inputDecoration: FieldDecoration(hint: getTranslated(context, 'phone_hint')),
      maxLength: 11,
      countries: ["SA"],
    );
  }

  Widget _subtitle(String textKey) {
    return Text(getTranslated(context, textKey));
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
      decoration: FieldDecoration(hint: getTranslated(context, hintKey)),
      validator: (value) {
        if (value == null) {
          return getTranslated(context, hintKey);
        }
        return null;
      },
    );
  }

  List<DropdownMenuItem> _buildDropDownItems(List choices) {
    return choices.map((choice) {
      return DropdownMenuItem(
        child: Text(choice.name),
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
