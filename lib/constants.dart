import 'package:covid_19/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding:
  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(25.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.yellowAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(25.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.yellowAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(25.0)),
  ),
  errorStyle: TextStyle(
    color: Colors.yellowAccent,
  )
);

final kTitleStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'CM Sans Serif',
  fontSize: 26.0,
  height: 1.5,
);

final kSubtitleStyle = TextStyle(
  color: Colors.white,
  fontSize: 18.0,
  height: 1.2,
);

final kSidebarStyle = TextStyle(
  color: Colors.black,
  fontSize: 18.0,
  height: 1.2,
);

class UserData{
  static var finalEmail;
  static var finalStatus;
  static var finalName;
  static var finalUID;
  static Color kColour;
  static SharedPreferences logindata;
}

const kHomeDecoration = BoxDecoration(
  gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomLeft,
      colors: [Colors.yellow,Colors.red]),
);


Future currentUserLogout(BuildContext context) async {
  try {
    FirebaseAuth.instance.signOut();
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    print('cleaned');
    Navigator.pushNamedAndRemoveUntil(
        context, WelcomeScreen.id, (Route<dynamic> route) => false);
  } catch (e) {}
}
