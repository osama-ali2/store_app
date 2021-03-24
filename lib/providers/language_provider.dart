import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yagot_app/singleton/AppSP.dart';
import 'package:yagot_app/singleton/dio.dart';

class LanguageProvider extends ChangeNotifier {
  String _langCode;


  getLanguageCode() {
    SharedPreferences.getInstance()
        .then((value) {
      _langCode = value.getString('language');
      print('get $_langCode');
    });
    return _langCode ;
  }

  setLanguageCode(String code) {
    _langCode = code;
    SharedPreferences.getInstance().then((value)  {
    _langCode = value.getString('language');
        print('set');
  });
    notifyListeners();
  }
}
