import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:yagot_app/constants/constants.dart';
import 'package:yagot_app/providers/general_provider.dart';
import 'package:yagot_app/screens/auth/login.dart';
import 'package:yagot_app/screens/common/widgets/option_list_tile.dart';
import 'package:yagot_app/screens/favourite/favourite.dart';
import 'package:yagot_app/screens/others/edit_profile.dart';
import 'package:yagot_app/screens/others/info_page.dart';
import 'package:yagot_app/screens/purchases/purchases.dart';
import 'package:yagot_app/screens/shipping_address/addresses.dart';
import 'package:yagot_app/screens/user_ads/user_ads.dart';
import 'package:yagot_app/utilities/helper_functions.dart';
import 'package:yagot_app/utilities/none_glow_scroll_behavior.dart';

class UserAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GeneralProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: white,
          body: ScrollConfiguration(
            behavior: NoneGlowScrollBehavior(),
            child: CustomScrollView(
              slivers: [
                buildSliverAppBar(context),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      if (provider.isAuth) ..._buildAuthOptions(context),
                      OptionListTile(
                        type: LANG_OPTION,
                        iconKey: 'global.svg',
                        titleKey: 'language',
                      ),
                      OptionListTile(
                          iconKey: 'information.svg',
                          titleKey: 'about_app',
                          page: InfoPage(
                              info: (provider.settingsModel != null)
                                  ? provider.settingsModel.aboutUs
                                  : null)),
                      OptionListTile(
                        iconKey: 'phone_call.svg',
                        titleKey: 'call_us',
                        page: EditProfile(),
                      ),
                      OptionListTile(
                          iconKey: 'shield.svg',
                          titleKey: 'privacy_policy',
                          page: InfoPage(
                              info: (provider.settingsModel != null)
                                  ? provider.settingsModel.policyPrivacy
                                  : null)),
                      SizedBox(height: 50.h),
                      OptionListTile(
                        iconKey: 'logout.svg',
                        titleKey: provider.isAuth ? "logout" : "login",
                        type: provider.isAuth ? LOGOUT_OPTION : NORMAL_OPTION,
                        page: LoginScreen(),
                      ),
                      SizedBox(height: 60.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _buildAuthOptions(BuildContext context) {
    return [
      OptionListTile(
        iconKey: 'mic.svg',
        titleKey: 'my_ads',
        page: UserAds(),
      ),
      OptionListTile(
          iconKey: "cart.svg",
          titleKey: "my_purchases",
          page: PurchasesScreen()),
      OptionListTile(
          iconKey: "favourite.svg",
          titleKey: "favourite",
          page: FavouriteScreen()),
      OptionListTile(
          iconKey: "pin.svg", titleKey: "addresses", page: AddressesScreen()),
      divider(context),
      OptionListTile(
          iconKey: "user.svg", titleKey: "edit_profile", page: EditProfile()),
    ];
  }

  SliverAppBar buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      brightness: Brightness.dark,
      title: Text(
        getTranslated(context, "my_account"),
        style: TextStyle(
          color: white,
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      pinned: true,
      elevation: 0,
      backgroundColor: primary,
      expandedHeight: 220.h,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Stack(children: [
          Image.asset(
            "assets/images/my_account_background.png",
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: 240.h,
            alignment: Alignment.topCenter,
          ),
          PositionedDirectional(
            height: 70.h,
            start: 30.w,
            top: 100.h,
            child: _aboutOwnerRow(),
          ),
        ]),
      ),
      bottom: _appBarBottom(context),
    );
  }

  PreferredSize _appBarBottom(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(40.h),
      child: Container(
        height: 40.h,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          ),
        ),
      ),
    );
  }

  Widget _aboutOwnerRow() {
    return Consumer<GeneralProvider>(
      builder: (context, provider, child) {
        var image = '';
        var certified = true;
        var username = 'guest';
        var email = '';
        if (provider.profileData != null &&
            provider.profileData.client != null) {
          var client = provider.profileData.client;
          image = client.image;
          certified = client.certified;
          username = client.name;
          email = client.email;
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                _userImage(image),
                if (certified)
                  SvgPicture.asset("assets/icons/white_check_in.svg")
              ],
            ),
            SizedBox(width: 20.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: TextStyle(
                    color: white,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.none,
                  ),
                ),
                Text(email,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      color: white,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.none,
                    )),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _userImage(String image) {
    return Container(
      width: 70.h,
      height: 70.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: white,
      ),
      child: ClipOval(
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/images/place_holder.png',
          imageErrorBuilder: (context, error, stackTrace) =>
              Image.asset('assets/images/place_holder.png'),
          image: image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget divider(BuildContext context) {
    return Container(
      height: .5,
      width: MediaQuery.of(context).size.width * .9,
      margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 30.w),
      color: grey3.withOpacity(.7),
    );
  }
}

class Language {
  int id;

  String name;

  String code;

  Language({@required this.id, @required this.name, @required this.code});
}
