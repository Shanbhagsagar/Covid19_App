import 'package:covid_19/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import 'home_screen.dart';


class LoadingScreen extends StatefulWidget {
  static const String id = 'loading_screen';

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool userExist;


  @override
  void initState() {
    ifLoggedIn();
    super.initState();
  }

  void ifLoggedIn() async {
    UserData.logindata = await SharedPreferences.getInstance();
    userExist = (UserData.logindata.getBool('userexist') ?? false);
    if (userExist == true) {
      Navigator.popAndPushNamed(
          context, HomeSreen.id);
    }
    else{
      Navigator.popAndPushNamed(context, WelcomeScreen.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomLeft,
              colors: [Colors.yellow, Colors.red]),
        ),
        child: Center(
          child: CircularProgressIndicator(
            strokeWidth: 3,
            backgroundColor: Colors.red,
            valueColor: AlwaysStoppedAnimation<Color>(
                Colors.red.shade900),
          ),
        ),
      ),),
    );
  }
}
