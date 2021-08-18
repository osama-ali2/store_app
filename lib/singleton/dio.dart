
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yagot_app/singleton/APIsData.dart';
import 'package:yagot_app/singleton/AppSP.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<AppShPref>(
      () => AppShPref(preferences: sharedPreferences));

  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  getIt
      .registerLazySingleton(() async => await SharedPreferences.getInstance());
  Dio client = Dio(BaseOptions(
    followRedirects: false,
    validateStatus: (status) {
      return status < 500;
    },
    //Todo : link language with localization.
    headers: {
      "lang": 'ar',
    },
  ));
  getIt.registerLazySingleton<Dio>(() => client);
  getIt.registerLazySingleton<APIsData>(() => APIsData(client: getIt()));
}
