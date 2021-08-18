import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:yagot_app/providers/general_provider.dart';
import 'package:yagot_app/screens/add_product/add_product.dart';
import 'package:yagot_app/screens/conversations/conversation_screen.dart';
import 'package:yagot_app/screens/main/home.dart';
import 'package:yagot_app/screens/main/user_account.dart';
import 'package:yagot_app/screens/notifications/notifications.dart';
import 'package:yagot_app/utilities/custom_icons.dart';
import 'package:yagot_app/utilities/helper_functions.dart';

class MainPages extends StatefulWidget {
  @override
  _MainPagesState createState() => _MainPagesState();
}

class _MainPagesState extends State<MainPages> {
  int bottomBarIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: bottomBarIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageView(),
      bottomNavigationBar: _bottomNB(),
      floatingActionButton: _floatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }

  FloatingActionButton _floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      clipBehavior: Clip.hardEdge,
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return AddProduct();
        }));
      },
      child: Icon(
        Icons.add,
        color: white,
        size: 40,
      ),
      backgroundColor: primary,
    );
  }

  _bottomNB() {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: black.withOpacity(.06),
            offset: Offset(0, -7),
            blurRadius: 20,
            spreadRadius: 10),
      ]),
      child: BottomNavigationBar(
        items: _bottomBarItems(),
        type: BottomNavigationBarType.fixed,
        currentIndex: bottomBarIndex,
        onTap: (index) {
          if (index == 3) {
            //UserAccount
              context.read<GeneralProvider>().getProfile(context, () {}, () {});
          }
          setState(() {
            bottomBarIndex = index;
          });
          _pageController.jumpToPage(index);
        },
        selectedIconTheme: IconThemeData(
          color: primary,
          size: 20,
        ),
        selectedItemColor: primary,
        selectedLabelStyle: TextStyle(
          color: primary,
          fontSize: 12.sp,
        ),
        showUnselectedLabels: true,
        unselectedItemColor: accent,
        unselectedLabelStyle: TextStyle(
          color: accent,
          fontSize: 12.sp,
        ),
        iconSize: 24,
      ),
    );
  }

  List<BottomNavigationBarItem> _bottomBarItems() {
    return [
      BottomNavigationBarItem(
        icon: Icon(CustomIcons.main),
        label: getTranslated(context, "main"),
      ),
      BottomNavigationBarItem(
        icon: Icon(CustomIcons.chat),
        label: getTranslated(context, "messages"),
      ),
      BottomNavigationBarItem(
        icon: Icon(CustomIcons.bell),
        label: getTranslated(context, "notifications"),
      ),
      BottomNavigationBarItem(
        icon: Icon(CustomIcons.profile),
        label: getTranslated(context, "my_account"),
      ),
    ];
  }

  _pageView() {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: [
        HomeScreen(),
        ConversationsScreen(),
        NotificationsScreen(),
        UserAccount(),
      ],
    );
  }
}
