import 'package:flutter/material.dart';
import 'package:yagot_app/utilities/helper_functions.dart';
import 'package:flutter_screenutil/size_extension.dart';
class AppButton extends StatelessWidget {
  final String title;

  final Function onPressed;

  AppButton({this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
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
        onPressed: onPressed,
        child: Text(
          getTranslated(context, title),
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
