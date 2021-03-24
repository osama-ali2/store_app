import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yagot_app/lang/app_locale.dart';

const String LANGUAGE_CODE = "language_code";

String getTranslated(BuildContext context, String key) {
  return AppLocalization.of(context).getTranslated(key).toString();
}
String getDate(String sDateTime){
  final DateTime dateTime = DateTime.tryParse(sDateTime);
  String date = "0000-00-00";
  if (dateTime != null) {
    date = '${dateTime.year}-${dateTime.month}-${dateTime.day}';
  }
  return date ;
}

 setLangCodeToPref(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(LANGUAGE_CODE, languageCode);
}

 Future<String> getLangCodeFromPref() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(LANGUAGE_CODE);
  return languageCode ;
}