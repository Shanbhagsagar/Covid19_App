import 'package:covid_19/screens/hospital_list_screen.dart';
import 'package:covid_19/screens/icmr_news.dart';
import 'package:covid_19/screens/registration_screen.dart';
import 'package:covid_19/screens/statistics_screen.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../constants.dart';


class UpdateArgs {
  final String uName;
  final String uEmail;

  UpdateArgs(this.uName, this.uEmail);
}

class CustomDrawer extends StatelessWidget {
  final Function closeDrawer;

  const CustomDrawer({Key key, this.closeDrawer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Container(
      color: Colors.white,
      width: mediaQuery.size.width * 0.60,
      height: mediaQuery.size.height,
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 281,
            color: Colors.grey.withAlpha(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Text(
                  UserData.finalName??'',
                  style: kSidebarStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                QrImage(
                  data: UserData.finalUID,
                  version: 2,
                  size: 150,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 20.0,
                  width: 80.0,
                decoration: BoxDecoration(
                  color: UserData.kColour,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                ),
//                Icon(
//                  Icons.radio_button_unchecked,
//                  color: UserData.kColour,
//                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, LineChartCovid.id);
            },
            leading: Icon(Icons.equalizer),
            title: Text(
              "Statistics",
            ),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, HospitalListScreen.id);
            },
            leading: Icon(Icons.local_hospital),
            title: Text(
              "Hospital & Testing Centers",
            ),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, IcmrNews.id);
            },
            leading: Icon(Icons.new_releases),
            title: Text(
              "ICMR Notification",
            ),
          ),
          Divider(
            height: 1,
            color: Colors.grey[400],
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, RegistrationScreen.id,arguments: UpdateArgs(UserData.finalName,UserData.finalEmail));
            },
            leading: Icon(Icons.settings),
            title: Text("Change Account Info"),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              currentUserLogout(context);
            },
            leading: Icon(Icons.exit_to_app),
            title: Text("Log Out"),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
