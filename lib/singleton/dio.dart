import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yagot_app/singleton/APIsData.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:yagot_app/singleton/AppSP.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  Dio client = Dio(BaseOptions(
    //Todo : link language with localization.
    headers: {"lang": 'ar'},
  ));
  getIt.registerLazySingleton<Dio>(() => client);
  getIt.registerLazySingleton<APIsData>(() => APIsData(client: getIt()));
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<AppSharedPreferences>(
      () => AppSharedPreferences(preferences: sharedPreferences));

  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  getIt
      .registerLazySingleton(() async => await SharedPreferences.getInstance());
}

showError(BuildContext context, error) {
  print("showError = " + error.toString());
  if (error is DioError) {
    print("showError = " + (error).error.toString());
    if ((error).response != null) {
      final jsonData = json.decode(error.response.toString());
      print("(error as DioError).response != null >>> " +
          error.response.toString());
      print("(yasmina >>> " + jsonData.toString());
    } else {
      // errorModel = BodyAPIModel(error.type);
    }
  } else {
    print("showError >>> else");
  }
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(error.message.toString()),
    duration: Duration(seconds: 4),
  ));
}
