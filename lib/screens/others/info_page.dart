import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:yagot_app/models/settings/InformationModel.dart';
import 'package:yagot_app/utilities/none_glow_scroll_behavior.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class InfoPage extends StatelessWidget {
  final InformationModel info;

  InfoPage({@required this.info});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: transparent,
        title: Text((info != null) ? info.title : ''),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: black,
          ),
        ),
      ),
      body: (info != null)
          ? _bodyContent(context)
          : Center(child: CircularProgressIndicator()),
    );
  }

  _bodyContent(BuildContext context) {
    return ScrollConfiguration(
      behavior: NoneGlowScrollBehavior(),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(30.r),
        child: Html(
          data: info.details ?? '',
        ),
      ),
    );
  }
}
