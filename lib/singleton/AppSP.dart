import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yagot_app/models/home/client.dart';

class AppShPref {
  final SharedPreferences preferences;

  AppShPref({@required this.preferences});

  static const USER = 'user';

  static const TOKEN = 'token';
  static const USERNAME = 'username';

  static const LANGUAGE = 'language';

  static setUser(Client user) {}

  Future<void> setToken(String token) async {
    await preferences.setString(TOKEN, token);
  }

  String getToken() {
    return preferences.getString(TOKEN);
  }

  Future<void> setUsername(String username) async {
    await preferences.setString(USERNAME, username);
  }

  String getUsername() {
    return preferences.getString(USERNAME);
  }

  Future<void> setLang(String code) async {
    await preferences.setString(LANGUAGE, code);
  }

  String getLang() {
    return preferences.getString(LANGUAGE);
  }
}
