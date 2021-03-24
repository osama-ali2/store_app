import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yagot_app/models/home/client.dart';

class AppSharedPreferences {
  final SharedPreferences preferences;

  AppSharedPreferences({@required this.preferences});

  static const USER = 'user';

  static const TOKEN = 'token';

  static const  LANGUAGE = 'language';

  static setUser(Client user) {}

  Future<void> setToken(String token) async {
    await preferences.setString(TOKEN, token);
  }
  String getToken(){
   return  preferences.getString(TOKEN) ;
  }
  Future<void> setLang(String code) async{
    await preferences.setString(LANGUAGE, code);
  }
  String getLang(){
    return preferences.getString(LANGUAGE);
  }
}
