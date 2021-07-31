import 'package:covid_19/screens/forgot_password_screen.dart';
import 'package:covid_19/screens/hospital_list_screen.dart';
import 'package:covid_19/screens/loading_screen.dart';
import 'package:covid_19/screens/onboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:covid_19/screens/welcome_screen.dart';
import 'package:covid_19/screens/login_screen.dart';
import 'package:covid_19/screens/registration_screen.dart';
import 'package:covid_19/screens/home_screen.dart';
import 'package:flutter/services.dart';
import 'package:covid_19/screens/icmr_news.dart';
import 'package:covid_19/screens/statistics_screen.dart';
import 'package:covid_19/screens/hospital_list_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black,
    statusBarColor: Colors.black,
    statusBarIconBrightness: Brightness.light
  ));
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeData(fontFamily: 'JockeyOne'),
      initialRoute: LoadingScreen.id,
      routes: {
        LoadingScreen.id:(context)=>LoadingScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        PasswordRecovery.id:(context)=>PasswordRecovery(),
        OnboardingScreen.id:(context)=>OnboardingScreen(),
        HomeSreen.id:(context) =>HomeSreen(),
        IcmrNews.id:(context) =>IcmrNews(),
        HospitalListScreen.id:(context) =>HospitalListScreen(),
        LineChartCovid.id:(context) =>LineChartCovid(),
      },
    );
  }
}
