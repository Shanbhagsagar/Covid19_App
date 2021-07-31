import 'package:covid_19/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_19/constants.dart';


class OnboardingScreen extends StatefulWidget {
  static const String id = 'onboard_screen';
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int selectedRadioTile;

  @override
  void initState() {
    super.initState();
    selectedRadioTile = 1;
  }

  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 22.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.yellow : Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomLeft,
                colors: [Colors.yellow, Colors.red]),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 600.0,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'images/doc.png',
                                ),
                                height: 250.0,
                                width: 250.0,
                              ),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'Getting started',
                              style: kTitleStyle,
                            ),
                            SizedBox(height: 25.0),
                            Text(
                              'We would like to ask you about your current status before we get started',
                              style: kSubtitleStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'images/test.png',
                                ),
                                height: 250.0,
                                width: 250.0,
                              ),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'Are you diagonised with Covid-19 currently ?',
                              style: kTitleStyle,
                            ),
                            Form(
                              child: Column(
                                children: <Widget>[
                                  RadioListTile(
                                    value: 1,
                                    groupValue: selectedRadioTile,
                                    title: Text("Dont Know"),
                                    onChanged: (val) {
                                      setSelectedRadioTile(val);
                                    },
                                    activeColor: Colors.white,
                                  ),
                                  RadioListTile(
                                    value: 2,
                                    groupValue: selectedRadioTile,
                                    title: Text("Yes"),
                                    onChanged: (val) {
                                      setSelectedRadioTile(val);
                                    },
                                    activeColor: Colors.white,
                                    selected: false,
                                  ),
                                  RadioListTile(
                                    value: 3,
                                    groupValue: selectedRadioTile,
                                    title: Text("No"),
                                    onChanged: (val) {
                                      setSelectedRadioTile(val);
                                    },
                                    activeColor: Colors.white,
                                    selected: false,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 40.0),
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'images/allset.png',
                                ),
                                height: 200.0,
                                width: 200.0,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              "You're all set",
                              style: kTitleStyle,
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              "Your account has been set-up, please click on submit to visit your dashboard",
                              style: kSubtitleStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage == 2
                    ? Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: FlatButton(
                            shape: CircleBorder(),
                            onPressed: () async {
                              FirebaseAuth _auth = FirebaseAuth.instance;
                              final user = await _auth.currentUser();
                              DocumentReference documentReference =
                                  await Firestore.instance
                                      .collection('users')
                                      .document(user.uid);
                              documentReference
                                  .updateData({'isNewUser': false});
                              if (selectedRadioTile == 2){
                                documentReference
                                    .updateData({'isInfected': true});
                                UserData.logindata.setBool('isinfected', true);
                              }

                              else if (selectedRadioTile == 3){
                                documentReference
                                    .updateData({'isInfected': false});
                                UserData.logindata.setBool('isinfected', false);
                              }
                              else
                                {
                                  documentReference
                                      .updateData({'isInfected': null});
                                  UserData.logindata.setBool('isinfected', null);
                                }

                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  HomeSreen.id,
                                  (Route<dynamic> route) => false);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Submit',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.0,
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Text(''),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
