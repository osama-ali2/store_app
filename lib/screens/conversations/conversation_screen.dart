import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:yagot_app/screens/conversations/single_conversation.dart';
import 'package:yagot_app/utilities/custom_icons.dart';
import 'package:yagot_app/utilities/helper_functions.dart';

class ConversationsScreen extends StatefulWidget {
  @override
  _ConversationsScreenState createState() => _ConversationsScreenState();
}

class _ConversationsScreenState extends State<ConversationsScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<String> tabs;

  @override
  void initState() {
    super.initState();
    tabs = ["all", "closed", "opened"];
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          brightness: Brightness.light,
          elevation: 0,
          title: Text(
            getTranslated(context, "conversations"),
          ),
          centerTitle: true,
          leading:
          IconButton(
            onPressed: () {},
            icon: Icon(
              CustomIcons.search,
              color: grey1,
            ),
          ),
        ),
        body: SafeArea(
          child: _bodyContent(context),
        ));
  }

  _bodyContent(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 30.h),
          _bubbleTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView.builder(
                  itemBuilder: (context, position) {
                    return _conversationCard();
                  },
                  itemCount: 10,
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                ),
                ListView.builder(
                  itemBuilder: (context, position) {
                    return _conversationCard();
                  },
                  itemCount: 5,
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                ),
                ListView.builder(
                  itemBuilder: (context, position) {
                    return _conversationCard();
                  },
                  itemCount: 5,
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _bubbleTabBar() {
    return Stack(
      alignment: Alignment.center,
      children: [
        _tabBackground(),
        _tabItems(),
      ],
    );
  }

  Widget _tabBackground() {
    return Container(
      width: 315.w,
      height: 50.h,
      decoration: BoxDecoration(
          color: grey8, borderRadius: BorderRadius.circular(25.r)),
    );
  }

  Widget _tabItems() {
    return SizedBox(
      width: 322.w,
      child: TabBar(
        controller: _tabController,
        labelStyle: TextStyle(
            color: white,
            fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(
            color: accent),
        unselectedLabelColor: accent,
        tabs: List.generate(tabs.length, (index) {
          return Text(getTranslated(context, tabs[index]));
        }).toList(),
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BubbleTabIndicator(
          indicatorColor: primary,
          indicatorHeight: 50.h,
          indicatorRadius: 25.w,
          tabBarIndicatorSize: TabBarIndicatorSize.tab,
        ),
      ),
    );
  }

  Widget _conversationCard() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return SingleConversationPage();
            },
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: primary,
                shape: BoxShape.circle,
              ),
              child:
              Icon(
                CustomIcons.message_con,
                color: white,
                size: 18,

              ),
            ),
            Spacer(flex: 1),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "محمد أحمد ",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w100,

                      ),
                    ),
                    Text(
                      '22/01/2019',
                      style: TextStyle(
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w100,

                          color: grey2),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Text(
                  'نص الاستفسار نص الاستفسار',
                  style: TextStyle(
                    color: grey2,
                    // (conversation.isOpened)
                    //     ? Color(0xFF595B67)
                    //     : Color(0xFF00041D),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w100,
                    // (conversation.isOpened)
                    //     ? FontWeight.w100
                    //     : FontWeight.w600,
                  ),
                ),
              ],
            ),
            Spacer(flex: 5),
            (false)
                ? Container()
                : Container(
              alignment: Alignment.center,
              height: 20.h,
              width: 20.w,
              decoration: BoxDecoration(
                  color: red2, shape: BoxShape.circle),
              child: Center(
                child: Text(
                  "2",
                  style: TextStyle(
                    color: white,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _emptyBodyContent(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(flex: 4),
          SvgPicture.asset("assets/icons/empty_conversations.svg"),
          Spacer(flex: 1),
          Text(
            getTranslated(context, "no_conversations_currently"),
            style: TextStyle(
                fontSize: 16.sp,

                fontWeight: FontWeight.w600,
                color: accent),
          ),
          Spacer(flex: 4),
        ],
      ),
    );
  }
}
