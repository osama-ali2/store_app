import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:yagot_app/screens/common/widgets/app_button.dart';
import 'package:yagot_app/screens/common/widgets/app_text_field.dart';
import 'package:yagot_app/utilities/field_decoration.dart';
import 'package:yagot_app/utilities/helper_functions.dart';
import 'package:yagot_app/utilities/none_glow_scroll_behavior.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController username,
      email,
      phone,
      password,
      cPassword;
  FocusNode node1, node2, node3, node4, node5 ,  node6 , node7;
  bool obscurePassword = true;
  bool obscureCPassword = true;
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
    username = TextEditingController();
    email = TextEditingController();
    phone = TextEditingController();
    password = TextEditingController();
    cPassword = TextEditingController();
    node1 = FocusNode();
    node2 = FocusNode();
    node3 = FocusNode();
    node4 = FocusNode();
    node5 = FocusNode();
    node6 = FocusNode();
    node7 = FocusNode();
    countryItems = _buildDropDownItems(countries);
    cityItems = _buildDropDownItems(cities);
  }

  @override
  void dispose() {
    super.dispose();
    username.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    cPassword.dispose();
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
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                top: 30.h, bottom: 80.h, right: 30.w, left: 30.w),
            child: Column(
              children: [
                _userImage(),
                SizedBox(height: 30.h),
                _subtitle('user_name'),
                SizedBox(height: 10.h),
                AppTextField(
                  hintKey: 'user_name',
                  errorKey: 'user_name_error_message',
                  controller: username,
                  node: node1,
                  nextNode: node2,
                ),
                SizedBox(height: 20.h),
                _subtitle('email'),
                SizedBox(height: 10.h),
                AppTextField(
                  hintKey: 'email',
                  errorKey: 'empty_email_error_message',
                  controller: email,
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
                _dropDownButton(countryItems, "choose_country", true),
                SizedBox(height: 20.h),
                _subtitle("city"),
                SizedBox(height: 10.h),
                _dropDownButton(cityItems, "choose_city", false),
                SizedBox(height: 20.h),
                _subtitle('password'),
                SizedBox(height: 10.h),
                AppTextField(
                  hintKey: 'password',
                  errorKey: 'password_error_message',
                  controller: password,
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
                  controller: cPassword,
                  node: node7,
                  nextNode: null,
                  isObscured: obscureCPassword,
                ),
                SizedBox(height: 60.h),
                AppButton(
                  title: "save",
                  onPressed: () {
                    print(phone);
                    if (_formKey.currentState.validate()) {
                      Navigator.pop(context);
                    }
                  },
                ),
              ],

            ),
          ),
        ),
      ),
    );
  }

  InternationalPhoneNumberInput _phoneField() {
    return InternationalPhoneNumberInput(
      onInputChanged: null,
      textFieldController: phone,
      validator: (input) {
        if (input.isEmpty || input
            .trim()
            .length < 9) {
          return getTranslated(context, "phone_error_message");
        }
        return null;
      },
      focusNode: node3,
      formatInput: true,
      ignoreBlank: true,
      inputDecoration: FieldDecoration(hint: getTranslated(context, 'phone_hint')),
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
          color: primary,
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(7.r),
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
Widget _dropDownButton(List<DropdownMenuItem> dropItems, String hintKey,
    bool isCountry) {
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
    decoration: FieldDecoration(hint: getTranslated(context, hintKey)),
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

