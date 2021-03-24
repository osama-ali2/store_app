import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yagot_app/lang/app_locale.dart';
import 'package:yagot_app/models/product/product.dart';
import 'package:yagot_app/models/seller.dart';

class ProfilePreview extends StatefulWidget {
  @override
  _ProfilePreviewState createState() => _ProfilePreviewState();
}

class _ProfilePreviewState extends State<ProfilePreview> {
  Seller seller = Seller(image: '', description: '', name: 'd' ,email: 'le') ;

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
          backgroundColor: Colors.transparent,
          appBar: _appBar(context),
          body: _bodyContent(context),
        ),
      ],
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        AppLocalization.of(context).getTranslated("seller_profile"),
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontFamily: "NeoSansArabic",
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
        SizedBox(height: 40),
        _aboutOwnerRow(),
        SizedBox(height: 30),
        Row(
          children: [
            Spacer(),
            _contactButton(
              AppLocalization.of(context).getTranslated("send_message"),
              "assets/icons/message.svg",
            ),
            SizedBox(width: 20),
            _contactButton(AppLocalization.of(context).getTranslated("call"),
                "assets/icons/phone_call.svg"),
            Spacer(),
          ],
        ),
        SizedBox(height: 30),
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(top: 40, right: 40, left: 40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalization.of(context).getTranslated("ads"),
                  style: TextStyle(
                    fontFamily: "NeoSansArabic",
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00041D),
                    fontSize: 14,
                    decoration: TextDecoration.none,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, position) {
                      ProductModel currentProduct = seller.products[position];
                      return Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 2.5,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              currentProduct.details.image,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                            Spacer(flex: 1),
                            Column(
                              children: [
                                Text(
                                  currentProduct.details.title,
                                  style: TextStyle(
                                    color: Color(0xFF00041D),
                                    fontFamily: "NeoSansArabic",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 12),
                                // Text(
                                //   currentProduct.dateTime,
                                //   style: Theme.of(context).textTheme.headline2,
                                // ),
                              ],
                            ),
                            Spacer(flex: 4),
                            Text(
                              currentProduct.details.price,
                              style: TextStyle(
                                color: Color(0xFF595B67),
                                fontFamily: "NeoSansArabic",
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            Spacer(flex: 1),
                          ],
                        ),
                      );
                    },
                    itemCount: 5,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: 40),
                  ),
                ),
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
        SizedBox(width: 15),
        SizedBox(
          height: 70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                seller.name,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "NeoSansArabic",
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  decoration: TextDecoration.none,
                ),
              ),
              Text(seller.email,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "NeoSansArabic",
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
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
      width: 70,
      height: 70,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: NetworkImage(''), fit: BoxFit.cover)),
    );
  }

  Widget _contactButton(String type, String iconPath) {
    return MaterialButton(
      height: 50,
      minWidth: 130,
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      onPressed: () {},
      child: Row(
        children: [
          SvgPicture.asset(
            iconPath,
            color: Color(0xFF00014D),
          ),
          SizedBox(width: 10),
          Text(
            type,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w100,
              fontFamily: "NeoSansArabic",
              color: Color(0xFF00041D),
            ),
          ),
        ],
      ),
    );
  }
}
