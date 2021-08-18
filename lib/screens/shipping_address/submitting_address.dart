import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:yagot_app/screens/common/widgets/app_button.dart';
import 'package:yagot_app/utilities/helper_functions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubmittingAddress extends StatefulWidget {
  @override
  _SubmittingAddressState createState() => _SubmittingAddressState();
}

class _SubmittingAddressState extends State<SubmittingAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: _appBar(),
      body: _bodyContent(),
    );
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: white,
      title:
          Text(getTranslated(context,"add_new_address")),
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
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .05,
          vertical: MediaQuery.of(context).size.height * .07),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getTranslated(context,"determine_location_on_map"),
            style: TextStyle(
                color: accent,
                fontSize: 12.sp,
                fontWeight: FontWeight.normal),
          ),
          SizedBox(height: 24),
          Container(
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
                Container(
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
                      getTranslated(context,"edit"),
                      style: TextStyle(
                        color: white,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(6.r),
              border: Border.all(
                  color: grey4.withOpacity(.2), width: 1),
            ),
          ),
          SizedBox(height: 30),
          Text(
            getTranslated(context,"choose_address"),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: accent,
            ),
          ),
          SizedBox(height: 30),
          Text(
            getTranslated(context,"block"),
            style: TextStyle(
                color: blue2,
                fontSize: 12.sp,
                fontWeight: FontWeight.normal),
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(
                    color: accent.withOpacity(.16),
                    width: 1,
                  ),),
              hintText: getTranslated(context,"block"),
            ),
          ),
          SizedBox(height: 26),
          Text(
            getTranslated(context,"street"),
            style: TextStyle(
                color: blue2,
                fontSize: 12.sp,
                fontWeight: FontWeight.normal),
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: accent.withOpacity(.16),
                  width: 1,
                ),),
              hintText: getTranslated(context,"street"),
            ),
          ),
          SizedBox(height: 26),
          Text(
            getTranslated(context,"home_number_office"),
            style: TextStyle(
                color: blue2,
                fontSize: 12.sp,
                fontWeight: FontWeight.normal),
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: accent.withOpacity(.16),
                  width: 1,
                ),),
              hintText: "00",
            ),
          ),
          SizedBox(height: 60),
          AppButton(
            title: 'save_address',
            width: 0.9.sw,
            onPressed: (){},
          ),
        ],
      ),
    );
  }
}
