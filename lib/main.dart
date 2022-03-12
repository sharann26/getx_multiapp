import 'package:country_code_picker/country_localizations.dart';
import 'package:flutter/material.dart';
import 'package:multi_app/app/data/services/storage/service.dart';
import 'package:multi_app/app/modules/landing/view.dart';
import 'package:multi_app/app/modules/onboard/view.dart';
import 'package:multi_app/app/modules/todo/home/binding.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:after_layout/after_layout.dart';

main() async {
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      supportedLocales: [
        Locale('en', 'US')
      ],
      localizationsDelegates: [CountryLocalizations.delegate],
      title: 'Getx ToDo',
      home: Splash(),
      debugShowCheckedModeBanner: false,
      initialBinding: HomeBinding(),
      builder: EasyLoading.init(),
    );
  }
}

class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Get.to(() => AppHomePage());
    } else {
      Get.to(() => OnboardPage());
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Image.asset('assets/images/splash.png',
            alignment: Alignment.center),
      ),
    );
  }
}

class AppHomePage extends StatelessWidget {
  const AppHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LandingPage();
  }
}