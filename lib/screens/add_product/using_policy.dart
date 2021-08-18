import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:yagot_app/screens/add_product/add_company.dart';
import 'package:yagot_app/screens/add_product/add_product.dart';
import 'package:yagot_app/screens/common/widgets/app_button.dart';
import 'package:yagot_app/utilities/helper_functions.dart';
import 'package:yagot_app/utilities/none_glow_scroll_behavior.dart';

class UsingPolicy extends StatefulWidget {
  final bool isCompany;

  UsingPolicy({this.isCompany});

  @override
  _UsingPolicyState createState() => _UsingPolicyState();
}

class _UsingPolicyState extends State<UsingPolicy> {
  bool isAccept = false;

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
      title: Text(getTranslated(
        context,
        widget.isCompany ? "companies_use_policy" : "hobbyist_use_policy",
      )),
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

  _bodyContent() {
    return Padding(
      padding: EdgeInsets.all(30.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _policyTitle(),
          SizedBox(height: 20),
          Expanded(child: _policyText()),
          SizedBox(height: 20),
          _acceptRow(),
          SizedBox(height: 30),
          AppButton(
            title: 'accept',
            onPressed: !isAccept
                ? null
                : () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return (widget.isCompany)
                              ? AddCompany()
                              : AddProduct();
                        },
                      ),
                    );
                  },
          )
        ],
      ),
    );
  }

  Widget _policyTitle() {
    return Text(
      getTranslated(
        context,
        widget.isCompany ? "companies_use_policy" : "hobbyist_use_policy",
      ),
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16.sp,
      ),
    );
  }

  Widget _policyText() {
    return ScrollConfiguration(
      behavior: NoneGlowScrollBehavior(),
      child: SingleChildScrollView(
        child: Text(
          'FakeProvider.getLongString(),',
          softWrap: true,
          style: TextStyle(height: 1.5),
        ),
      ),
    );
  }

  Widget _acceptRow() {
    return Row(
      children: [
        _checkbox(),
        SizedBox(width: 10),
        Text(getTranslated(context, "accept_use_policy")),
      ],
    );
  }

  Widget _checkbox() {
    return InkWell(
      onTap: () {
        setState(() {
          isAccept = !isAccept;
        });
      },
      child: Container(
        height: 20,
        width: 20,
        padding: EdgeInsets.all(4.r),
        child: SvgPicture.asset("assets/icons/correct.svg"),
        decoration: BoxDecoration(
          color: isAccept ? primary : transparent,
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(color: grey6, width: isAccept ? 0 : 1),
        ),
      ),
    );
  }
}
