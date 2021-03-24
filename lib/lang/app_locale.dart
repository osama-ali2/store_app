import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class AppLocalization {
  Locale _locale;
  AppLocalization(this._locale);

  static AppLocalization of(BuildContext context){
    return Localizations.of(context, AppLocalization);
  }

  Map<String,String> _langJson;

  Future _loadJson() async {
    String stringJson = await rootBundle.loadString('assets/langs/${_locale.languageCode}.json');
    Map<String,dynamic> jsonFile = jsonDecode(stringJson);
    _langJson = jsonFile.map((key, value) {
      return MapEntry(key, value.toString());
    });
  }

   String getTranslated(String key){
    return _langJson[key];
  }

  static const LocalizationsDelegate<AppLocalization> delegate =  AppLocalizationDelegate();
}


class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization>{
  const AppLocalizationDelegate();
  @override
  bool isSupported(Locale locale) {
    return ["en","ar"].contains(locale.languageCode.toLowerCase());
  }

  @override
  Future<AppLocalization> load(Locale locale) async{
    AppLocalization stringLocalization = AppLocalization(locale);
    await stringLocalization._loadJson();
    return stringLocalization;
  }

  @override
  bool shouldReload(AppLocalizationDelegate old)=>false;

}