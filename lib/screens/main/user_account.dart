import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yagot_app/main.dart';
import 'package:yagot_app/screens/favourite/favourite.dart';
import 'package:yagot_app/screens/others/edit_profile.dart';
import 'package:yagot_app/screens/others/info_page.dart';
import 'package:yagot_app/screens/purchases/purchases.dart';
import 'package:yagot_app/screens/shipping_address/addresses.dart';
import 'package:yagot_app/screens/auth/login.dart';
import 'package:yagot_app/screens/user_ads/empty.dart';
import 'package:yagot_app/screens/user_ads/user_ads.dart';
import 'package:yagot_app/utilities/helper_functions.dart';
import 'package:yagot_app/utilities/none_glow_scroll_behavior.dart';
import 'package:provider/provider.dart';
import 'package:yagot_app/providers/general_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:yagot_app/providers/language_provider.dart';

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
                      // if (provider.isLogin) _buildAuthOptions(context),
                      _optionCard(
                          context, "assets/icons/global.svg", "language", null),
                      _optionCard(
                          context,
                          "assets/icons/information.svg",
                          "about_app",
                          InfoPage(
                              info: (provider.settingsModel != null)
                                  ? provider.settingsModel.aboutUs
                                  : null)),
                      _optionCard(context, "assets/icons/phone_call.svg",
                          "call_us", EditProfile()),
                      _optionCard(
                          context,
                          "assets/icons/shield.svg",
                          "privacy_policy",
                          InfoPage(
                              info: (provider.settingsModel != null)
                                  ? provider.settingsModel.policyPrivacy
                                  : null)),
                      SizedBox(height: 50.h),
                      _optionCard(
                        context,
                        "assets/icons/logout.svg",
                        provider.isLogin ? "logout" : "login",
                        LoginScreen(),
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
      _optionCard(context, "assets/icons/mic.svg", "my_ads", UserAds()),
      _optionCard(
          context, "assets/icons/cart.svg", "my_purchases", PurchasesScreen()),
      _optionCard(context, "assets/icons/favourite.svg", "favourite",
          FavouriteScreen()),
      _optionCard(
          context, "assets/icons/pin.svg", "addresses", AddressesScreen()),
      divider(context),
      _optionCard(
          context, "assets/icons/user.svg", "edit_profile", EditProfile()),
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
          fontFamily: "NeoSansArabic",
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
            topLeft: Radius.circular(30.w),
            topRight: Radius.circular(30.w),
          ),
        ),
      ),
    );
  }

  Widget _aboutOwnerRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            _userImage(),
            SvgPicture.asset("assets/icons/white_check_in.svg")
          ],
        ),
        SizedBox(width: 20.w),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'username',
              style: TextStyle(
                color: white,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.none,
              ),
            ),
            Text('user email',
                style: TextStyle(
                  color: white,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.none,
                )),
          ],
        ),
      ],
    );
  }

  Widget _userImage() {
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
          image: 'http/www.google.com',
          fit: BoxFit.cover,
          imageErrorBuilder: (context, error, stackTrace) =>
              Image.asset('assets/images/place_holder.png'),
        ),
      ),
    );
  }

  Widget _optionCard(
      BuildContext context, String iconKey, String titleKey, Widget route,
      {bool logout = false}) {
    return ListTile(
      onTap: () {
        if (route != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return route;
              },
            ),
          );
        } else if (logout) {
          Provider.of<GeneralProvider>(context, listen: false).logout();
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return LangDialog();
            },
          );
        }
      },
      leading: _icon(iconKey),
      trailing: Icon(
        CupertinoIcons.forward,
        color: accent,
      ),
      title: Text(getTranslated(context, titleKey)),
      contentPadding: EdgeInsetsDirectional.only(
          start: 30.w, end: 40.w, top: 5.h, bottom: 5.h),
    );
  }

  Widget _icon(String iconKey) {
    return Container(
      height: 40.h,
      width: 40.w,
      decoration: BoxDecoration(
        color: white1,
        borderRadius: BorderRadius.circular(10.w),
      ),
      padding: EdgeInsets.all(5.w),
      child: SvgPicture.asset(
        iconKey,
        color: primary,
        alignment: Alignment.center,
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

class LangDialog extends StatefulWidget {
  @override
  _LangDialogState createState() => _LangDialogState();
}

class _LangDialogState extends State<LangDialog> {
  int _selectedLangId;

  List<Language> languages;

  Locale currentLocal;

  @override
  void initState() {
    super.initState();
    languages = [
      Language(id: 0, name: "العربية", code: "ar"),
      Language(id: 1, name: "English", code: "en"),
    ];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentLocal = Localizations.localeOf(context);
    _selectedLangId = languages.firstWhere((language) {
      return language.code == currentLocal.languageCode;
    }).id;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: languages.length * 50.0 + 120.h,
        width: 280.w,
        padding:
            EdgeInsets.only(bottom: 20.h, right: 30.w, left: 30.w, top: 30.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              getTranslated(context, "change_language"),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.h),
            ...languages.map((language) {
              return _langChoice(context, language.name, language.id);
            }).toList(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  onPressed: () {
                    String langCode = languages.firstWhere((language) {
                      return language.id == _selectedLangId;
                    }).code;
                    Provider.of<LanguageProvider>(context, listen: false)
                        .setLanguageCode(langCode);
                    Navigator.pop(context);
                  },
                  child: Text(getTranslated(context, "yes")),
                  color: white,
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    SharedPreferences.getInstance()
                        .then((value) => print(value.getString('language')));
                  },
                  child: Text(getTranslated(context, "cancel")),
                  color: white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row _langChoice(BuildContext context, String name, int id) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        _selectCircle(context, id),
        SizedBox(width: 14.w),
        Text(name),
      ],
    );
  }

  _selectCircle(BuildContext context, int id) {
    bool isSelected = _selectedLangId == id;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedLangId = id;
        });
      },
      child: Container(
        height: 20.h,
        width: 20.w,
        margin: EdgeInsets.only(bottom: 20.h),
        decoration: BoxDecoration(
          color: isSelected ? primary : white,
          border: !isSelected ? Border.all(color: grey4, width: 2) : null,
          shape: BoxShape.circle,
        ),
        child: Align(
          child: SvgPicture.asset(
            "assets/icons/correct_2.svg",
            fit: BoxFit.cover,
            height: 8.h,
            width: 8.h,
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}

class Language {
  int id;

  String name;

  String code;

  Language({@required this.id, @required this.name, @required this.code});
}
