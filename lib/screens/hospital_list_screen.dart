import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../components/reusablecard.dart';

class HospitalListScreen extends StatefulWidget {
  static const String id = 'hosp_screen';
  @override
  _HospitalListScreenState createState() => _HospitalListScreenState();
}

class _HospitalListScreenState extends State<HospitalListScreen> {
  String dropdownValue = "Dadar";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('Hospital List'),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomLeft,
              colors: [Colors.yellow, Colors.red]),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FutureBuilder(
                  future: DefaultAssetBundle.of(context)
                      .loadString("assets/jsonHospList.json"),
                  builder: (context, details) {
                    LinkedHashMap rawData = json.decode(details.data);
                    Iterable<String> cityList = rawData.keys;
                    if (details.hasData) {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: dropdownValue,
                          elevation: 16,
                          icon: Icon(
                            Icons.arrow_downward,
                            color: Colors.black,
                          ),
                          style: kSubtitleStyle.copyWith(
                            color: Colors.black,
                          ),
                          underline: Container(
                            height: 2,
                            color: Colors.red,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
                          items: cityList
                              .map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                        ),
                      );
                    }
                    return Center();
                  }),
              FutureBuilder(
                builder: (context, details) {
                  var rawData = json.decode(details.data);
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
//                      return ListTile(
//                        isThreeLine: true,
//                        trailing: ,
//                        title: Text(rawData[dropdownValue][index]['hosp_name']),
//                        subtitle: Text(rawData[dropdownValue][index]['hosp_address']),
//                      );
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 5,),
                            ReusableHospitalCard(
                              hospitalName: rawData[dropdownValue][index]['hosp_name'],
                              hospitalAddress: rawData[dropdownValue][index]['hosp_address'],
                              hospitalPhone: rawData[dropdownValue][index]['hosp_phone'],
                              hospitalUrl: rawData[dropdownValue][index]['hosp_direction'],
                            ),
                            SizedBox(height: 5,),
                          ],
                        ),
                      );
                    },
                    itemCount: rawData[dropdownValue].length??0,
                  );
                },
                future: DefaultAssetBundle.of(context)
                    .loadString("assets/jsonHospList.json"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
