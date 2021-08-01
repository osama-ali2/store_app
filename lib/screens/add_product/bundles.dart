import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yagot_app/screens/buying_product/payment_methods.dart';
import 'package:yagot_app/utilities/helper_functions.dart';
import 'package:yagot_app/utilities/none_glow_scroll_behavior.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Bundles extends StatefulWidget {
  @override
  _BundlesState createState() => _BundlesState();
}

class _BundlesState extends State<Bundles> {
  int selectedIndex = -1;

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
      title: Text(
        getTranslated(context, "bundles"),
      ),
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

  Widget _bodyContent() {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _subtitle("you_can_access_more_settings"),
          SizedBox(height: 25),
          _bodyText(getTranslated(context, "choose_subscription")),
          SizedBox(height: 15),
          Expanded(
            child: ScrollConfiguration(
              behavior: NoneGlowScrollBehavior(),
              child: ListView.builder(
                itemBuilder: (context, position) {
                  return _bundleCard(position);
                },
                itemCount: 7,
              ),
            ),
          ),
          _subscribeButton(),
        ],
      ),
    );
  }

  Widget _subtitle(String textKey) {
    return Text(
      getTranslated(context, textKey),
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _bodyText(String text) {
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.w400),
    );
  }

  Widget _bundleCard(int position) {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: (selectedIndex == position) ? Theme.of(context).primaryColor:Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF203152).withOpacity(.1),
            offset: Offset(0, 1),
            blurRadius: 6,
          ),
        ],
      ),
      child: ListTile(
        onTap: () {
          setState(() {
            selectedIndex = position;
          });
        },
        leading: SvgPicture.asset("assets/icons/yagot_logo.svg"),
        title: _bodyText("اسم الباقة"),
        trailing: Text("50 ريال"),
      ),
    );
  }

  Widget _subscribeButton() {
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
        onPressed: (selectedIndex == -1)
            ? null
            : () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return PaymentMethodsScreen();
                    },
                  ),
                );
              },
        disabledColor: Colors.grey.shade700,
        child: Text(
          getTranslated(context, "subscribe"),
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

