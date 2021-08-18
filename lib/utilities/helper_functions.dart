import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:yagot_app/lang/app_locale.dart';
import 'package:yagot_app/screens/common/widgets/app_dialog.dart';
import 'package:yagot_app/screens/main/main_page_view.dart';
import 'package:yagot_app/singleton/APIsData.dart';
import 'package:yagot_app/singleton/AppSP.dart';
import 'package:yagot_app/singleton/dio.dart';

import 'custom_exceptions.dart';

const String LANGUAGE_CODE = "language_code";

String getTranslated(BuildContext context, String key) {
  return AppLocalization.of(context).getTranslated(key).toString();
}

String getDate(String sDateTime) {
  final DateTime dateTime = DateTime.tryParse(sDateTime);
  String date = "0000-00-00";
  if (dateTime != null) {
    date = '${dateTime.year}-${dateTime.month}-${dateTime.day}';
  }
  return date;
}

setLangCodeToPref(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(LANGUAGE_CODE, languageCode);
}

Future<String> getLangCodeFromPref() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(LANGUAGE_CODE);
  return languageCode;
}

parseError(BuildContext context, error){
  if (error is ResponseException) {
    showError(context, error.model.message);
  } else if(error is DioError){
    if(error.error is SocketException){
      showError(context, getTranslated(context, 'no_connection'));
    }
  }else{
    showError(context, getTranslated(context, 'general_error_message'));
  }
}

showError(BuildContext context, message, {Function onPress}) {
  showDialog(
    context: context,
    builder: (context) => AppDialog(
      title: message,
      color: red2,
      buttonLabel: 'close',
      onPressBtn: onPress ??
          () {
            Navigator.pop(context);
          },
      borderSize: 1,
    ),
    barrierDismissible: false,
  );
}

showSuccess(BuildContext context, message, {Function onPress}) {
  showDialog(
    context: context,
    builder: (context) => AppDialog(
      title: message,
      color: green1,
      icon: 'correct.svg',
      buttonLabel: 'close',
      onPressBtn: onPress ??
          () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => MainPages()),
                (route) => false);
          },
      borderSize: 1,
    ),
    barrierDismissible: false,
  );
}

updateToken() {
  getIt<APIsData>()
      .client
      .options
      .headers
      .addAll({'Authorization': getIt<AppShPref>().getToken()});
}
