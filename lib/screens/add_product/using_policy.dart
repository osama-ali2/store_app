import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yagot_app/models/product/product.dart';
import 'package:yagot_app/screens/add_product/add_company.dart';
import 'package:yagot_app/screens/add_product/add_product.dart';
import 'package:yagot_app/utilities/helper_functions.dart';
import 'package:yagot_app/utilities/none_glow_scroll_behavior.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      backgroundColor: Colors.white,
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
          color: Color(0xFF00041D),
        ),
      ),
    );
  }

  _bodyContent() {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _policyTitle(),
          SizedBox(height: 20),
          Expanded(child: _policyText()),
          SizedBox(height: 20),
          _acceptRow(),
          SizedBox(height: 30),
          _acceptButton()
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
        padding: EdgeInsets.all(4),
        child: SvgPicture.asset("assets/icons/correct.svg"),
        decoration: BoxDecoration(
          color: isAccept ? Theme.of(context).primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Color(0xFF9EA1AF), width: isAccept ? 0 : 1),
        ),
      ),
    );
  }

  Widget _acceptButton() {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
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
        onPressed: !isAccept
            ? null
            : () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return (widget.isCompany) ? AddCompany() : AddProduct();
                    },
                  ),
                );
              },
        disabledColor: Colors.grey.shade700,
        child: Text(
          getTranslated(context, "accept"),
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
}
