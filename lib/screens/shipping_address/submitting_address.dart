import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: _bodyContent(),
    );
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title:
          Text(getTranslated(context,"add_new_address")),
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
                color: Color(0xFF00041D),
                fontSize: 12.sp,
                fontWeight: FontWeight.normal),
          ),
          SizedBox(height: 24),
          Container(
            height: 102,
            width: MediaQuery.of(context).size.width * .9,
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "شارع الرحمة-حي السلام\nجدة",
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: Color(0xFF00041D),
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
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: 22,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Color(0xFF303442).withOpacity(.5),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(6),
                          bottomLeft: Radius.circular(6)),
                    ),
                    child: Text(
                      getTranslated(context,"edit"),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                  color: Color(0xFF9C9C9C).withOpacity(.2), width: 1),
            ),
          ),
          SizedBox(height: 30),
          Text(
            getTranslated(context,"choose_address"),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF00041D),
            ),
          ),
          SizedBox(height: 30),
          Text(
            getTranslated(context,"block"),
            style: TextStyle(
                color: Color(0xFF10131D),
                fontSize: 12.sp,
                fontWeight: FontWeight.normal),
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Color(0xFF00041D).withOpacity(.16),
                    width: 1,
                  ),),
              hintText: getTranslated(context,"block"),
            ),
          ),
          SizedBox(height: 26),
          Text(
            getTranslated(context,"street"),
            style: TextStyle(
                color: Color(0xFF10131D),
                fontSize: 12.sp,
                fontWeight: FontWeight.normal),
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Color(0xFF00041D).withOpacity(.16),
                  width: 1,
                ),),
              hintText: getTranslated(context,"street"),
            ),
          ),
          SizedBox(height: 26),
          Text(
            getTranslated(context,"home_number_office"),
            style: TextStyle(
                color: Color(0xFF10131D),
                fontSize: 12.sp,
                fontWeight: FontWeight.normal),
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Color(0xFF00041D).withOpacity(.16),
                  width: 1,
                ),),
              hintText: "00",
            ),
          ),
          SizedBox(height: 60),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width * .9,
            child: RaisedButton(
              onPressed: () {},
              child: Text(
                getTranslated(context,"save_address"),
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
          ),
        ],
      ),
    );
  }
}
