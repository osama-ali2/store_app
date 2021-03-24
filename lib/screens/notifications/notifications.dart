import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yagot_app/utilities/helper_functions.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: SafeArea(child: _bodyContent(context)),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      brightness: Brightness.light,
      title: Text(
        getTranslated(context, "notifications"),
      ),
      centerTitle: true,
    );
  }

  Widget _bodyContent(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, positions) {
        return _notificationCard(context);
      },
      itemCount: 20,
      padding: const EdgeInsets.only(top: 5),
    );
  }

  Widget _notificationCard(BuildContext context) {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 15),
      margin: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        border: BorderDirectional(
          bottom: BorderSide(
            color: Color(0xFF203152).withOpacity(.2),
            width: .5,
          ),
        ),
      ),
      child: Row(
        children: [
          _bellIcon(),
          SizedBox(width: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "نص عنوان",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 2),
              Text(
                "نص فرعي مولد من مولد النص تجريبي",
              )
            ],
          )
        ],
      ),
    );
  }

  _bellIcon() {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: Color(0xFF1F4282).withOpacity(.2),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(8),
      child: SvgPicture.asset(
        "assets/icons/bell.svg",
        color: Color(0xFF1F4282),
      ),
    );
  }
}
