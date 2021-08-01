import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yagot_app/utilities/helper_functions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyAds extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              getTranslated(context,"my_ads"),
              style: Theme.of(context).textTheme.headline1,
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
          body: _bodyContent(context),
        ),
      ],
    );

  }

  _bodyContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Spacer(flex: 6),
        SvgPicture.asset("assets/icons/empty_ads.svg"),
        Spacer(flex: 2),
        Text(getTranslated(context,"no_ads_currently"),style: TextStyle(
            color: Color(0xFF00041D),
            fontSize: 14.sp,
            fontFamily: "NeoSansArabic",
            fontWeight: FontWeight.bold),),
        Spacer(flex: 1),
        Text(getTranslated(context,"you_can_add_new_ad"),style: TextStyle(
            color: Color(0xFF00041D),
            fontSize: 12.sp,
            fontFamily: "NeoSansArabic",
            fontWeight: FontWeight.w100),),
        Spacer(flex: 3),
        _addNewAdButton(context),
        Spacer(flex: 13),

      ],
    );
  }

  Widget _addNewAdButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:30),
      child: SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: FlatButton(
          onPressed: () {
            // if (_formKey.currentState.validate()) {
            //   //todo: verify the phone
            // } else {}
          },
          color: Theme.of(context).primaryColor,
          child: Text(
            getTranslated(context,"add_new_ad"),
            style: TextStyle(color: Colors.white, fontFamily: "NeoSansArabic"),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

}
