import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:yagot_app/screens/shared/app_button.dart';

import 'package:yagot_app/utilities/helper_functions.dart';
import 'package:yagot_app/utilities/none_glow_scroll_behavior.dart';
import 'package:flutter_screenutil/size_extension.dart';
class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController userNameCtr,
      emailCtr,
      phoneCtr,
      passwordCtr,
      confirmPasswordCtr;
  String userName, email, phone, password, confirmPassword;
  FocusNode node1, node2, node3, node4, node5;
  bool obscurePassword = true;
  final _formKey = GlobalKey<FormState>();
  int countryValue, cityValue;
  String countryError, cityError;
  List<String> countries = ["فلسطين", "مصر", "سوريا"],
      cities = ["فلسطين", "مصر", "سوريا"];
  List<DropdownMenuItem> countryItems, cityItems;
  ImagePicker picker = ImagePicker();
  File image;

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
    countryItems = _buildDropDownItems(countries);
    cityItems = _buildDropDownItems(cities);
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
      body: _bodyContent(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: white,
      title: Text(
        getTranslated(context, "edit_profile"),
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
    return ScrollConfiguration(
      behavior: NoneGlowScrollBehavior(),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            _userImage(),
            SizedBox(height: 30.h),
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
            _dropDownButton(countryItems, "choose_country", true),
            SizedBox(height: 20.h),
            _subtitle("city"),
            SizedBox(height: 10.h),
            _dropDownButton(cityItems, "choose_city", false),
            SizedBox(height: 20.h),
            _subtitle('password'),
            SizedBox(height: 10.h),
            _textField("password", "password_error_message", passwordCtr,
                Fields.PASSWORD, node4, node5),
            SizedBox(height: 20.h),
            _subtitle('confirm_password'),
            SizedBox(height: 10.h),
            _textField("confirm_password", "password_error_message",
                confirmPasswordCtr, Fields.CONFIRM_PASSWORD, node5, null),
            SizedBox(height: 60.h),
            AppButton(
              title: "save",
              onPressed: () {
                userName = userNameCtr.text;
                email = emailCtr.text;
                phone = phoneCtr.text.trim();
                password = passwordCtr.text;
                confirmPassword = confirmPasswordCtr.text;
                print(phone);
                if (_formKey.currentState.validate()) {
                  Navigator.pop(context);
                }
              },
            ),
          ],
          padding: EdgeInsets.only(top: 30.h, bottom: 80.h, right: 30.w, left: 30.w),
        ),
      ),
    );
  }

  InternationalPhoneNumberInput _phoneField() {
    return InternationalPhoneNumberInput(
      onInputChanged: null,
      textFieldController: phoneCtr,
      validator: (input) {
        if (input.isEmpty || input.trim().length < 9) {
          return getTranslated(context, "phone_error_message");
        }
        return null;
      },
      focusNode: node3,
      formatInput: true,
      ignoreBlank: true,
      inputDecoration: _decoration("phone_hint"),
      maxLength: 11,
      countries: ["SA"],
    );
  }

  _userImage() {
    return Align(
      alignment: Alignment.center,
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          Container(
              height: 100.h,
              width: 100.w,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: (image == null)
                        ? ExactAssetImage("assets/images/person1.JPG")
                        : FileImage(image),
                    fit: BoxFit.cover),
                shape: BoxShape.circle,
              )),
          _editImageBtn(),
        ],
      ),
    );
  }

  _editImageBtn() {
    return GestureDetector(
      onTap: () {
        _pickImage();
      },
      child: Container(
        height: 30.h,
        width: 30.h,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(7.h),
        child: SvgPicture.asset("assets/icons/pencil.svg"),
      ),
    );
  }

  _pickImage() async {
    PickedFile file = await picker.getImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        image = File(file.path);
      });
    }
  }

  Widget _subtitle(String textKey) {
    return Text(getTranslated(context, textKey));
  }

  InputDecoration _decoration(String hintKey) {
    return InputDecoration(
      hintText: getTranslated(context, hintKey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.h),
        borderSide:
            BorderSide(color: accent.withOpacity(.2), width: 1),
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
          obscureText:
              (field == Fields.PASSWORD || field == Fields.CONFIRM_PASSWORD)
                  ? obscurePassword
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
            if (field == Fields.EMAIL &&
                EmailValidator.validate(input)) {
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
                    obscurePassword = !obscurePassword;
                  });
                },
                icon: Icon(
                  (obscurePassword) ? Icons.visibility : Icons.visibility_off,
                ),
                padding: EdgeInsets.symmetric(vertical: 15.h),
              )
            : Container(),
      ],
    );
  }

  Widget _dropDownButton(
      List<DropdownMenuItem> dropItems, String hintKey, bool isCountry) {
    return DropdownButtonFormField(
      items: dropItems,
      onChanged: (value) {
        isCountry
            ? setState(() {
                countryValue = value;
              })
            : setState(() {
                cityValue = value;
              });
      },
      iconEnabledColor: primary,
      value: isCountry ? countryValue : cityValue,
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
}

enum Fields {
  USER_NAME,
  EMAIL,
  PASSWORD,
  CONFIRM_PASSWORD,
}
