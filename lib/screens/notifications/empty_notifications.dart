import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yagot_app/utilities/helper_functions.dart';

class EmptyNotifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _bodyContent(context),
    );
  }

  Widget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
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
          color: Color(0xFF00041D),
        ),
      ),
    );
  }

  _bodyContent(BuildContext context) {
    return Align(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 60),
          SvgPicture.asset(
            "assets/icons/empty_not.svg",
          ),
          SizedBox(height: 60),
          Text(
            getTranslated(context, "no_notifications_currently"),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}
