import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:yagot_app/utilities/helper_functions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class RemoveSheet extends StatelessWidget {
  final String title, description;
  final Function onPressedYes ;
  RemoveSheet(this.title, this.description,this.onPressedYes);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: MediaQuery.of(context).size.height * .48,
        margin: EdgeInsets.only(top: 15.h),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(40.h)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.2),
              offset: Offset(0, -5),
              blurRadius: 3,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(flex: 4),
            Text(
              getTranslated(context, title),
              style: TextStyle(
                color: accent,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
                decoration: TextDecoration.none,
                fontFamily: "NeoSansArabic",
              ),
            ),
            Spacer(flex: 4),
            Container(
              height: 60.h,
              width: 60.w,
              padding: EdgeInsets.all(20.h),
              decoration: BoxDecoration(
                color: red2,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset("assets/icons/remove.svg"),
            ),
            Spacer(flex: 6),
            Text(
              getTranslated(context, description),
              style: TextStyle(
                  color: accent, fontWeight: FontWeight.normal,
              fontSize: 14.sp,
              decoration: TextDecoration.none,
              fontFamily: "NeoSansArabic",
              ),
            ),
            Spacer(flex: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50.h,
                  width: 150.w,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: accent.withOpacity(.16),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                    )
                  ]),
                  child: RaisedButton(
                    onPressed: onPressedYes,
                    child: Text(
                     getTranslated(context
                         , "yes_remove"),
                      style: TextStyle(
                        color: white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    color: primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                ),
                SizedBox(width: 15.w),
                Container(
                  height: 50.h,
                  width: 150.w,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: accent.withOpacity(.16),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                    )
                  ]),
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      getTranslated(context, "cancel"),
                      style: TextStyle(
                        color: accent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    color:white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      side: BorderSide(
                        color: accent,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Spacer(flex: 5),

          ],
        ),
      ),
    );
  }
}
