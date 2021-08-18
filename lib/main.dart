import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
// import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:yagot_app/lang/app_locale.dart';
import 'package:yagot_app/providers/general_provider.dart';
import 'package:yagot_app/providers/language_provider.dart';
import 'package:yagot_app/singleton/dio.dart' as dio;

import 'screens/main/splash_screen.dart';

//Sentry is for detect and track all the bugs and errors that arrived when it is in live mode and is used by customers
// final sentry = SentryClient(SentryOptions(
//     dsn:
//         "https://d6295b7f79044ec9b02bec955b78889e@o505988.ingest.sentry.io/5595224")); // change dsn with your own

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  dio.init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => GeneralProvider()),
    ChangeNotifierProvider(create: (_) => LanguageProvider()),
  ], child: YagotApp()));
  // runZonedGuarded(
  //     () => runApp(MultiProvider(
  //         providers: [ChangeNotifierProvider(create: (_) => GeneralProvider())],
  //         child: YagotApp())), (error, stackTrace) async {
  //   await sentry.captureException(error, stackTrace: stackTrace);
  // });
  // FlutterError.onError = (details, {bool forceReport = false}) {
  //   sentry.captureException(
  //     details.exception,
  //     stackTrace: details.stack,
  //   );
  // };
}

class YagotApp extends StatefulWidget {
  @override
  _YagotAppState createState() => _YagotAppState();
}

class _YagotAppState extends State<YagotApp> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: () {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: transparent,
          ),
          child: Consumer<LanguageProvider>(
            builder: (context, provider, child) {
              return MaterialApp(
                title: 'Yagot app',
                theme: ThemeData(
                  fontFamily: "NeoSansArabic",
                  primaryColor: primary,
                  primaryColorLight: primary,
                  primaryColorDark: primary,
                  hintColor: accent.withOpacity(.5),
                  scaffoldBackgroundColor: white,
                  appBarTheme: AppBarTheme(
                    color: white,
                    elevation: 0,
                    centerTitle: true,
                    textTheme: _appBarTextTheme(),
                  ),
                  textTheme: _appTextTheme(),
                ),
                debugShowCheckedModeBanner: false,
                home: SplashScreen(),
                localizationsDelegates: [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  AppLocalization.delegate,
                ],
                supportedLocales: [
                  Locale("ar", ""),
                  Locale("en", ""),
                ],

                localeResolutionCallback: (currentLocal, supportedLocales) {
                  if (currentLocal != null) {
                    for (Locale locale in supportedLocales) {
                      if (currentLocal.languageCode == locale.languageCode) {
                        print('local');
                        return locale;
                      }
                    }
                  }
                  return supportedLocales.first;
                },
                locale: (provider.getLanguageCode() != null)
                    ? Locale(provider.getLanguageCode(), "")
                    : null,
              );
            },
          ),
        );
      },
    );
  }

  TextTheme _appBarTextTheme() {
    return TextTheme(
      headline6: TextStyle(
        color: accent,
        fontSize: 18.sp,
        fontFamily: "NeoSansArabic",
        fontWeight: FontWeight.w600,
      ),
    );
  }

  TextTheme _appTextTheme() {
    return TextTheme(
        headline1: TextStyle(
          color: accent,
          fontWeight: FontWeight.bold,
          fontSize: 16.sp,
        ),
        headline2: TextStyle(
          color: grey2,
          fontSize: 12.sp,
          fontWeight: FontWeight.normal,
        ),
        headline3: TextStyle(
            color: accent, fontSize: 14.sp, fontWeight: FontWeight.normal),
        bodyText1: TextStyle(
            color: grey1, fontSize: 12.sp, fontWeight: FontWeight.normal));
  }
}
