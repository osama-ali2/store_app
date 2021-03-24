import 'package:flutter/material.dart';
import 'package:yagot_app/lang/app_locale.dart';
import 'package:yagot_app/utilities/helper_functions.dart';
import 'package:yagot_app/utilities/none_glow_scroll_behavior.dart';

class InfoPage extends StatelessWidget {

  final String title , information ;
  InfoPage({@required this.title, @required this.information});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
            getTranslated(context , title)
        ),
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
      body: _bodyContent(context),
    );
  }

  _bodyContent(BuildContext context) {
    return ScrollConfiguration(
      behavior: NoneGlowScrollBehavior(),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(30),
        child: Text(information ,softWrap: true,style: Theme.of(context).textTheme.headline3,),
      ),
    );
  }

}
