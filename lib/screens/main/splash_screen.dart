import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yagot_app/constants/colors.dart';

import 'main_page_view.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() {
    Timer(Duration(seconds: 5), popSplash);
  }

  popSplash() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return MainPages();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.lerp(Alignment.topLeft, Alignment.topRight, .9),
          end: Alignment.lerp(Alignment.bottomLeft, Alignment.bottomRight, .2),
          colors: [
            blue3,
            blue4,
          ],
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: SvgPicture.asset(
              "assets/icons/full_logo.svg",
              color: white,
              height: 120.h,
            ),
          ),
          Positioned(
            right: 0,
            bottom: -250.h,
            child: SvgPicture.asset('assets/icons/logo_splash.svg',),
          ),
        ],
      ),
    );
  }
}
