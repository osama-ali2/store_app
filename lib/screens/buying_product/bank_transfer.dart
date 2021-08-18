import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:yagot_app/screens/common/widgets/app_button.dart';
import 'package:yagot_app/utilities/helper_functions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BankTransfer extends StatefulWidget {
  @override
  _BankTransferState createState() => _BankTransferState();
}

class _BankTransferState extends State<BankTransfer> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameTextController;

  TextEditingController _accountFromTextController;

  TextEditingController _accountToTextController;

  FocusNode _nodeOne;

  FocusNode _nodeTwo;

  FocusNode _nodeThree;
  FocusNode _nodeFour;

  int _bankChoiceValue;
  String dropdownError = "";

  List<String> _banks = [
    "بنك فلسطين",
    "بنك الانتاج",
    "بنك القاهرة عمان",
    "البنك الاسلامي الفلسطيني",
  ];
  List<DropdownMenuItem> dropItems;
  final picker = ImagePicker();
  File image;
  String imageName = "NO FILE EXIST";

  @override
  void initState() {
    super.initState();
    _nameTextController = TextEditingController();
    _accountFromTextController = TextEditingController();
    _accountToTextController = TextEditingController();
    _nodeOne = FocusNode();
    _nodeTwo = FocusNode();
    _nodeThree = FocusNode();
    _nodeFour = FocusNode();

    dropItems = _buildDropDownItems(_banks);
  }

  @override
  void dispose() {
    super.dispose();
    _nameTextController.dispose();
    _accountFromTextController.dispose();
    _accountToTextController.dispose();
    _nodeOne.dispose();
    _nodeTwo.dispose();
    _nodeThree.dispose();
    _nodeFour.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: transparent,
        title: Text(
          getTranslated(context, "bank_transfer"),
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
      body: _bodyContent(),
    );
  }

  _bodyContent() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 30.h),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              getTranslated(context, "bank_transfer_details"),
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: accent,
              ),
            ),
            SizedBox(height: 20),
            Text(
              getTranslated(context, "amount") + ": 2000 ريال",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: accent,
              ),
            ),
            SizedBox(height: 20),
            _fieldTitleText(getTranslated(context, "full_name")),
            SizedBox(height: 10),
            _nameField(),
            SizedBox(height: 20),
            _fieldTitleText(
                getTranslated(context, "account_number_transferred_from")),
            SizedBox(height: 10),
            _accountFromField(),
            SizedBox(height: 20),
            _fieldTitleText(
                getTranslated(context, "account_number_transferred_to")),
            SizedBox(height: 10),
            _accountToField(),
            SizedBox(height: 20),
            _fieldTitleText(getTranslated(context, "bank")),
            SizedBox(height: 10),
            _dropDownButton(dropItems),
            SizedBox(height: 20),
            _fieldTitleText(
                getTranslated(context, "attach_payment_receipt_photo")),
            SizedBox(height: 10),
            _addFileButton(),
            SizedBox(height: 50),
            AppButton(
              title: 'continue',
              onPressed: () {
                if (_bankChoiceValue == null) {
                  setState(() {
                    dropdownError = getTranslated(context, "choose_bank");
                  });
                } else {
                  setState(() {
                    dropdownError = "";
                  });
                }
                if (_formKey.currentState.validate()) {
                } else {}
              },
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
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

  Widget _fieldTitleText(String title) {
    return Text(
      title,
      style: TextStyle(
          color: accent, fontSize: 14.sp, fontWeight: FontWeight.normal),
    );
  }

  Widget _nameField() {
    return TextFormField(
      controller: _nameTextController,
      autofocus: false,
      focusNode: _nodeOne,
      keyboardType: TextInputType.name,
      validator: (input) {
        if (input.isEmpty) {
          return getTranslated(context, "full_name_error_message");
        }
        return null;
      },
      decoration: _fieldDecoration(getTranslated(context, "full_name")),
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (input) {
        FocusScope.of(context).requestFocus(_nodeTwo);
      },
    );
  }

  Widget _accountFromField() {
    return TextFormField(
      controller: _accountFromTextController,
      focusNode: _nodeTwo,
      validator: (input) {
        if (input.isEmpty) {
          return getTranslated(context, "account_number_error_message");
        }
        return null;
      },
      decoration: _fieldDecoration(
          getTranslated(context, "account_number_transferred_from")),
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (input) {
        FocusScope.of(context).requestFocus(_nodeThree);
      },
      keyboardType: TextInputType.number,
    );
  }

  Widget _accountToField() {
    return TextFormField(
      controller: _accountToTextController,
      focusNode: _nodeThree,
      validator: (input) {
        if (input.isEmpty) {
          return getTranslated(context, "account_number_error_message");
        }
        return null;
      },
      decoration: _fieldDecoration(
          getTranslated(context, "account_number_transferred_to")),
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (input) {
        FocusScope.of(context).requestFocus(_nodeFour);
      },
      keyboardType: TextInputType.number,
    );
  }

  Widget _addFileButton() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            _pickImage();
          },
          child: Container(
            height: 50,
            width: 160,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: accent.withOpacity(.1),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: accent, width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/icons/cloud_upload.svg"),
                SizedBox(width: 10),
                Text(getTranslated(context, "add_file"))
              ],
            ),
          ),
        ),
        (image != null)
            ? Image.file(
                image,
                height: 50,
                width: 50,
              )
            : Container(),
        Expanded(
            child: Text(
          imageName,
        )),
      ],
    );
  }

  Future _pickImage() async {
    PickedFile file = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (file != null) {
        image = File(file.path);
        imageName = image.absolute.path.split("/").last;
      } else {
        imageName = "NO FILE EXIST";
      }
    });
  }

  List<DropdownMenuItem> _buildDropDownItems(List<String> banks) {
    return banks.map((bank) {
      return DropdownMenuItem(
        child: Text(bank),
        value: _banks.indexOf(bank),
      );
    }).toList();
  }

  _dropDownButton(List<DropdownMenuItem> dropItems) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 60,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: accent.withOpacity(.16),
            ),
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: DropdownButton(
            items: dropItems,
            onChanged: (value) {
              setState(() {
                _bankChoiceValue = value;
              });
            },
            hint: Text(getTranslated(context, "choose_bank")),
            iconEnabledColor: blue6,
            value: _bankChoiceValue,
            focusNode: _nodeFour,
            isExpanded: true,
            underline: Container(),
            onTap: () {
              FocusScope.of(context).unfocus();
            },
          ),
        ),
        Text(
          dropdownError,
          style: TextStyle(
            color: red2,
            wordSpacing: 2,
            height: 1.5,
          ),
        )
      ],
    );
  }
}
