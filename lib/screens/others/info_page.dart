import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:yagot_app/lang/app_locale.dart';
import 'package:yagot_app/models/settings/InformationModel.dart';
import 'package:yagot_app/utilities/helper_functions.dart';
import 'package:yagot_app/utilities/none_glow_scroll_behavior.dart';

class InfoPage extends StatelessWidget {
  final InformationModel info;

  InfoPage({@required this.info});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text((info != null) ? info.title : ''),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
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
        padding: EdgeInsets.all(30),
        child: Html(
          data: info.details ?? '',
        ),
      ),
    );
  }
}
