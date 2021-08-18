import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:yagot_app/models/home/client.dart';
import 'package:yagot_app/screens/common/widgets/contact_button.dart';
import 'package:yagot_app/screens/conversations/single_conversation.dart';
import 'package:yagot_app/utilities/helper_functions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePreview extends StatefulWidget {
  final Client client;

  ProfilePreview({@required this.client});

  @override
  _ProfilePreviewState createState() => _ProfilePreviewState();
}

class _ProfilePreviewState extends State<ProfilePreview> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/profile_background.png",
          fit: BoxFit.contain,
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.topCenter,
        ),
        Scaffold(
          backgroundColor: transparent,
          appBar: _appBar(context),
          body: _bodyContent(context),
        ),
      ],
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: transparent,
      elevation: 0,
      title: Text(
        getTranslated(context, "seller_profile"),
        style: TextStyle(
          color: white,
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.share),
        ),
      ],
    );
  }

  Widget _bodyContent(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40.h),
        _aboutOwnerRow(),
        SizedBox(height: 30.h),
        Row(
          children: [
            Spacer(),
    ContactButton(
    titleKey: 'send_message',
    iconPath: 'message.svg',
    color: white,
    borderColor: white,
    textColor: accent,
    onPressed: _goToMessage(),
    ),

            SizedBox(width: 20.w),
            ContactButton(
              titleKey: 'call',
              iconPath: 'phone_call.svg',
              color: white,
              borderColor: white,
              textColor: accent,
              onPressed: (){
                _goToPhoneApp(widget.client.fullMobile);
              },
            ),
            Spacer(),
          ],
        ),
        SizedBox(height: 30.h),
        Expanded(
          child: Container(
            padding:  EdgeInsets.only(top: 40.h, right: 40.w, left: 40.w),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.r),
                topRight: Radius.circular(30.r),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getTranslated(context,"ads"),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: accent,
                    fontSize: 14.sp,
                    decoration: TextDecoration.none,
                  ),
                ),
                // Expanded(
                //   child: ListView.builder(
                //     itemBuilder: (context, position) {
                //       ProductModel currentProduct ;
                //       return Card(
                //         clipBehavior: Clip.antiAlias,
                //         elevation: 2.5,
                //         margin: EdgeInsets.symmetric(vertical: 10.h),
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(8),
                //         ),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Image.asset(
                //               currentProduct.details.image,
                //               width: 80,
                //               height: 80,
                //               fit: BoxFit.cover,
                //             ),
                //             Spacer(flex: 1),
                //             Column(
                //               children: [
                //                 Text(
                //                   currentProduct.details.title,
                //                   style: TextStyle(
                //                     color: Color(0xFF00041D),
                //                     fontWeight: FontWeight.bold,
                //                     fontSize: 14,
                //                   ),
                //                 ),
                //                 SizedBox(height: 12),
                //                 // Text(
                //                 //   currentProduct.dateTime,
                //                 //   style: TextStyle(
                //           color: grey2,
                //           fontSize: 12.sp,
                //           fontWeight: FontWeight.normal,
                //         ),,
                //                 // ),
                //               ],
                //             ),
                //             Spacer(flex: 4),
                //             Text(
                //               currentProduct.details.price,
                //               style: TextStyle(
                //                 color: Color(0xFF595B67),
                //                 fontWeight: FontWeight.w500,
                //                 fontSize: 14,
                //               ),
                //             ),
                //             Spacer(flex: 1),
                //           ],
                //         ),
                //       );
                //     },
                //     itemCount: 5,
                //     padding: EdgeInsets.symmetric(vertical: 40.h),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _aboutOwnerRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 30),
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            _userImage(),
            SvgPicture.asset("assets/icons/white_check_in.svg")
          ],
        ),
        SizedBox(width: 15.w),
        SizedBox(
          height: 70.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.client.name,
                style: TextStyle(
                  color: white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  decoration: TextDecoration.none,
                ),
              ),
              Text(widget.client.email??"email",
                  style: TextStyle(
                    color: white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    decoration: TextDecoration.none,
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _userImage() {
    return Container(
      width: 70.r,
      height: 70.r,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: NetworkImage(widget.client.image), fit: BoxFit.cover)),
    );
  }

  _goToMessage() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SingleConversationPage()));
  }

  _goToPhoneApp(String number) async {
    var _url = 'tel:$number';
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }
}
