import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_19/components/navigator_menu.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';
import 'package:covid_19/constants.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/DescColumn.dart';

class HomeSreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeSreenState createState() => _HomeSreenState();
}

class _HomeSreenState extends State<HomeSreen> {
  final _auth = FirebaseAuth.instance.currentUser();
  FirebaseUser loggedInUser;
  DateTime backButtonPressedTime;
  FSBStatus drawerStatus;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getCurrentUStatus();
  }

  void getCurrentUStatus() async {
    try {
      final user = await _auth;
      DocumentSnapshot documentReference =
          await Firestore.instance.collection('users').document(user.uid).get();
      if (user != null)
        UserData.finalStatus = documentReference.data['isInfected'];
      else if (user == null)
        UserData.finalStatus = UserData.logindata.getBool('isinfected');
      if (UserData.finalStatus==true)
        UserData.kColour = Colors.red[700];
      else if(UserData.finalStatus==false)
        UserData.kColour = Colors.green;
      else
        UserData.kColour = Colors.grey[600];
      setState(() {
        UserData.finalStatus;
        UserData.kColour;
      });
    } catch (e) {}
  }

  void getCurrentUser() async {
    try {
      final user = await _auth;
      if (user != null) {
        setState(() {
          UserData.finalName = user.displayName;
          UserData.finalEmail = user.email;
          UserData.finalUID = user.uid;
        });
      }
      if (user == null) {
        setState(() {
          UserData.finalEmail = UserData.logindata.getString('email');
          UserData.finalName = UserData.logindata.getString('name');
          UserData.finalUID = UserData.logindata.getString('uid');
        });
      }
    } catch (e) {}
  }

  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();
    bool backButton = backButtonPressedTime == null ||
        currentTime.difference(backButtonPressedTime) > Duration(seconds: 1);

    if (backButton) {
      backButtonPressedTime = currentTime;
      Toast.show("Double tap to exit", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FoldableSidebarBuilder(
          drawerBackgroundColor: Colors.yellow,
          drawer: CustomDrawer(
            closeDrawer: () {
              setState(() {
                drawerStatus = FSBStatus.FSB_CLOSE;
              });
            },
          ),
          screenContents: buildWillPopScope(context),
          status: drawerStatus,
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.deepPurple,
            child: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                drawerStatus = drawerStatus == FSBStatus.FSB_OPEN
                    ? FSBStatus.FSB_CLOSE
                    : FSBStatus.FSB_OPEN;
              });
            }),
      ),
    );
  }

  WillPopScope buildWillPopScope(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Container(
        height: double.infinity,
        decoration: kHomeDecoration,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.deepPurple[700],
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15.0),
                      bottomLeft: Radius.circular(15.0),
                    )
                ),
                padding: EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Covid-19',
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.pink,
                          ),
                        ),
                        Image.asset(
                          'images/indian_flag.png',
                          height: 60.0,
                          width: 60.0,
                        )
                      ],
                    ),
                    Text(
                      'Are you feeling sick?',
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'If you feel sick with any of covid-19 symptoms please call us immediately for help.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 17.0,
                        wordSpacing: 1.0,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Material(
                            elevation: 5.0,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30.0),
                            child: MaterialButton(
                                shape: CircleBorder(),
                                minWidth: 120.0,
                                height: 42.0,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.sms,
                                    ),
                                    SizedBox(
                                        width:10.0
                                    ),
                                    Text(
                                      'SMS',
                                      style: TextStyle(
                                        fontSize: 17.0,
                                      ),
                                    ),
                                  ],
                                ),
                                onPressed: (){
                                  launch('sms:+91 9819430739?body=PID:%20${UserData.finalUID};%20Covid%20Emergency%20Help!!');
                                }),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Material(
                            elevation: 5.0,
                            color: Colors.red.shade900,
                            borderRadius: BorderRadius.circular(30.0),
                            child: MaterialButton(
                                minWidth: 120.0,
                                height: 42.0,
                                shape: CircleBorder(),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.phone_forwarded,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                        width:10.0
                                    ),
                                    Text(
                                      'Call',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17.0,
                                      ),
                                    ),
                                  ],
                                ),
                                onPressed: (){
                                  launch('tel:+91 11 23978046');
                                }),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Symptoms :',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w600,
                            fontSize: 27.0,
                            color: Colors.red.shade900,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      height: 120.0,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          SizedBox(
                            width: 40.0,
                          ),
                          DescColumn(
                              img: 'images/s1.png',
                              disease: 'Headache'
                          ),
                          SizedBox(
                            width: 40.0,
                          ),
                          DescColumn(
                              img: 'images/s2.png',
                              disease: 'Cough and Sneeze'
                          ),
                          SizedBox(
                            width: 40.0,
                          ),
                          DescColumn(
                              img: 'images/s3.png',
                              disease: 'High Fever'
                          ),
                          SizedBox(
                            width: 40.0,
                          ),
                          DescColumn(
                              img: 'images/s4.png',
                              disease: 'Sore Throat'
                          ),
                          SizedBox(
                            width: 30.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Contagion :',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w600,
                            fontSize: 27.0,
                            color: Colors.red.shade900,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      height: 120.0,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          SizedBox(
                            width: 10.0,
                          ),
                          DescColumn(
                              img: 'images/co1.png',
                              disease: 'Personal Contact'
                          ),
                          SizedBox(
                            width: 40.0,
                          ),
                          DescColumn(
                              img: 'images/co2.png',
                              disease: 'Sneeze'
                          ),
                          SizedBox(
                            width: 40.0,
                          ),
                          DescColumn(
                              img: 'images/co3.png',
                              disease: 'Contaminated Object'
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Prevention :',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w600,
                            fontSize: 27.0,
                            color: Colors.red.shade900,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      height: 120.0,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          SizedBox(
                            width: 30.0,
                          ),
                          DescColumn(
                              img: 'images/p1.png',
                              disease: 'Wash Hands'
                          ),
                          SizedBox(
                            width: 55.0,
                          ),
                          DescColumn(
                              img: 'images/p2.png',
                              disease: 'Use Mask'
                          ),
                          SizedBox(
                            width: 60.0,
                          ),
                          DescColumn(
                              img: 'images/p3.png',
                              disease: 'Go To Doctor'
                          ),
                          SizedBox(
                            width: 30.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 60.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
