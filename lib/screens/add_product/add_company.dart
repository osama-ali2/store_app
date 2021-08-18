import 'package:flutter/material.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:yagot_app/screens/add_product/bundles.dart';
import 'package:yagot_app/screens/common/widgets/app_button.dart';
import 'package:yagot_app/screens/shipping_address/edit_address.dart';
import 'package:yagot_app/utilities/helper_functions.dart';
import 'package:yagot_app/utilities/none_glow_scroll_behavior.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yagot_app/utilities/enums.dart';

class AddCompany extends StatefulWidget {
  @override
  _AddCompanyState createState() => _AddCompanyState();
}

class _AddCompanyState extends State<AddCompany> {
  TextEditingController _companyController;
  TextEditingController _recordController;
  TextEditingController _blockController;
  TextEditingController _streetController;
  TextEditingController _homeNumController;
  FocusNode node1, node2, node3, node4, node5;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _companyController = TextEditingController();
    _recordController = TextEditingController();
    _blockController = TextEditingController();
    _streetController = TextEditingController();
    _homeNumController = TextEditingController();

    node1 = FocusNode();
    node2 = FocusNode();
    node3 = FocusNode();
    node4 = FocusNode();
    node5 = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();

    _companyController.dispose();
    _recordController.dispose();
    _blockController.dispose();
    _streetController.dispose();
    _homeNumController.dispose();

    node1.dispose();
    node2.dispose();
    node3.dispose();
    node4.dispose();
    node5.dispose();

    _formKey.currentState.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _bodyContent(),
    );
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: white,
      title: Text(
        getTranslated(context, "adding_company"),
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
            _subtitle("add_company_information"),
            SizedBox(height: 30),
            _fieldName("company_name"),
            SizedBox(height: 12),
            _textField("company_name", "enter_company_name", _companyController,
                FieldType.companyName, node1, node2),
            SizedBox(height: 20),
            _fieldName("commercial_record"),
            SizedBox(height: 12),
            _textField("commercial_record", "enter_commercial_record",
                _recordController, FieldType.commercialRecord, node2, node3),
            SizedBox(height: 30),
            _subtitle("you_can_detect_location_on_map"),
            SizedBox(height: 25),
            _addressDetails(),
            SizedBox(height: 25),
            _subtitle("writing_address_information_manually"),
            SizedBox(height: 20),
            _fieldName("block"),
            SizedBox(height: 12),
            _textField("block", "enter_block", _blockController,
                FieldType.block, node3, node4),
            SizedBox(height: 20),
            _fieldName("street"),
            SizedBox(height: 12),
            _textField("street", "enter_street", _streetController,
                FieldType.street, node4, node5),
            SizedBox(height: 20),
            _fieldName("home_number_office"),
            SizedBox(height: 12),
            _textField("00", "enter_home_number", _streetController,
                FieldType.homeNumber, node5, null),
            SizedBox(height: 60),
            AppButton(title: 'add',onPressed: () {
              if (_formKey.currentState.validate()) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return Bundles();
                    },
                  ),
                );
              }
            },),
          ],
          padding: EdgeInsets.only(right: 30.w, left: 30.w, top: 40.h, bottom: 100.h),
        ),
      ),
    );
  }

  _subtitle(String titleKey) {
    return Text(
      getTranslated(context, titleKey),
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  _fieldName(String nameKey) {
    return Text(
      getTranslated(context, nameKey),
      style: TextStyle(
        fontWeight: FontWeight.normal,
      ),
    );
  }

  _textField(String hintKey, String errorKey, TextEditingController controller,
      FieldType field, FocusNode node, FocusNode nextNode) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: (field == FieldType.homeNumber)
            ? hintKey
            : getTranslated(context, hintKey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide:
              BorderSide(color: accent.withOpacity(.2), width: 1),
        ),
      ),
      focusNode: node,
      onSaved: (input) {
        if (field == FieldType.homeNumber) {
          FocusScope.of(context).unfocus();
        } else {
          FocusScope.of(context).requestFocus(nextNode);
        }
      },
      textInputAction: (field == FieldType.homeNumber)
          ? TextInputAction.done
          : TextInputAction.next,
      validator: (input) {
        if (input.isEmpty) {
          return getTranslated(context, errorKey);
        }
        return null;
      },
    );
  }

  _addressDetails() {
    return Container(
      height: 102,
      width: MediaQuery.of(context).size.width * .9,
      padding: EdgeInsets.all(16.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "شارع الرحمة-حي السلام\nجدة",
            style: TextStyle(
                fontSize: 12.sp,
                color: accent,
                fontWeight: FontWeight.normal,
                height: 2.5),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return EditAddress();
                  },
                ),
              );
            },
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage("assets/images/small_map.png"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Container(
                alignment: Alignment.center,
                height: 22,
                width: 70,
                decoration: BoxDecoration(
                  color: blue7.withOpacity(.5),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(6.r),
                      bottomLeft: Radius.circular(6.r)),
                ),
                child: Text(
                  getTranslated(context, "edit"),
                  style: TextStyle(
                    color: white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: grey4.withOpacity(.2), width: 1),
      ),
    );
  }
}

