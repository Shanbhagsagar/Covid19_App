import 'package:flutter/material.dart';
import 'package:covid_19/components/rounded_button.dart';
import 'login_screen.dart';
import 'registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  AnimationController _imageController, _buttonController;
  Animation<double> _imageAnimation, _buttonAnimation;

  @override
  void initState() {
    super.initState();

    _imageController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    _imageAnimation =
        CurvedAnimation(parent: _imageController, curve: Curves.bounceOut);
    _imageController.forward();
    _imageController.addListener(() {
      setState(() {});
    });

    _buttonController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    _buttonAnimation =
        CurvedAnimation(parent: _buttonController, curve: Curves.decelerate);
    _buttonController.forward();
    _buttonController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _imageController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomLeft,
              colors: [Colors.yellow, Colors.red]),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40.0,
            ),
            ScaleTransition(
              scale: _imageAnimation,
              child: Image.asset(
                'images/covid19.png',
                height: 400.0,
                width: 400.0,
              ),
            ),
            ScaleTransition(
              scale: _buttonAnimation,
              child: RoundedButton(
                colour: Colors.red,
                title: 'Log In',
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
              ),
            ),
            ScaleTransition(
              scale: _buttonAnimation,
              child: RoundedButton(
                colour: Colors.redAccent.shade700,
                title: 'Register',
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
          ],
        ),
      ),
    );
  }
}
