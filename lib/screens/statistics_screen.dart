import 'package:covid_19/components/statistics_content.dart';
import 'package:flutter/material.dart';
import 'package:covid_19/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import '../components/reusablecard.dart';

class LineChartCovid extends StatefulWidget {
  static const String id = 'statistics_screen';

  @override
  _LineChartCovidState createState() => _LineChartCovidState();
}

class _LineChartCovidState extends State<LineChartCovid> {
  String dropdownValue = "Maharashtra";
  String dropdownValueCountry = "Afghanistan";
  final int _numPages = 2;
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
      duration: Duration(milliseconds: 500),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: isActive ? 8.0 : 15.0,
      width: isActive ? 22.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.red : Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('Statistics'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomLeft,
                colors: [Colors.yellow, Colors.red[400]]),
          ),
          child: PageView(
            physics: ClampingScrollPhysics(),
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: <Widget>[
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _buildPageIndicator(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'India Covid Cases : ',
                          style: kTitleStyle.copyWith(
                              fontFamily: 'RobotoSlab',
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      AspectRatio(
                        aspectRatio: 1.5,
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[800],
                                  blurRadius: 10.0, // soften the shadow
                                  spreadRadius: 0, //extend the shadow
                                  offset: Offset(
                                    5.0, // Move to right 10  horizontally
                                    5.0, // Move to bottom 10 Vertically
                                  ),
                                ),
                              ],
                              borderRadius: BorderRadius.all(
                                Radius.circular(18),
                              ),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 18.0, left: 12.0, top: 24, bottom: 12),
                            child: FutureBuilder(
                                future: getCovidDetailsDaily(),
                                builder: (context, details) {
                                  if (details.hasData) {
                                    return LineChart(
                                        mainData(details.data, false));
                                  }
                                  return Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.red,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.red.shade900),
                                    ),
                                  );
                                }),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FutureBuilder(
                          future: getCovidDetailsDaily(),
                          builder: (context, details) {
                            if (details.hasData) {
                              return ReusableCovidCard(
                                covidmonths: details.data,
                                emptyMode: false,
                              );
                            }
                            return ReusableCovidCard(
                              covidmonths: details.data,
                              emptyMode: true,
                            );
                          }),
                      SizedBox(
                        height: 40,
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Statewise Covid Cases :',
                          style: kTitleStyle.copyWith(
                              fontFamily: 'RobotoSlab',
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FutureBuilder(
                          future: getCovidDetailsState(),
                          builder: (context, details) {
                            if (details.hasData) {
                              return DropdownButton<String>(
                                value: dropdownValue,
                                isExpanded: true,
                                elevation: 16,
                                icon: Icon(
                                  Icons.arrow_downward,
                                  color: Colors.black,
                                ),
                                style: kSubtitleStyle.copyWith(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                underline: Container(
                                  height: 2,
                                  color: Colors.yellow,
                                ),
                                onChanged: (String newValue) {
                                  setState(() {
                                    dropdownValue = newValue;
                                  });
                                },
                                items: details.data.stateList
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              );
                            }
                            return Center();
                          }),
                      SizedBox(
                        height: 30,
                      ),
                      FutureBuilder(
                        future: getCovidDetailsState(),
                        builder: (context, details) {
                          if (details.hasData) {
                            return ReusableStateCovidCard(
                                covidmonths: details.data,
                                emptyMode: false,
                                dropdownValue: dropdownValue);
                          }
                          return CircularProgressIndicator(
                            backgroundColor: Colors.transparent,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.red.shade900),
                          );
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _buildPageIndicator(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Country-wise Covid Cases : ',
                          style: kTitleStyle.copyWith(
                              fontFamily: 'RobotoSlab',
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FutureBuilder(
                          future: getCovidDetailsCountryList(),
                          builder: (context, details) {
                            if (details.hasData) {
                              return DropdownButton<String>(
                                isExpanded: true,
                                value: dropdownValueCountry,
                                elevation: 15,
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
                                    dropdownValueCountry = newValue;
                                  });
                                },
                                items: details.data.countryList
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              );
                            }
                            return Center();
                          }),
                      SizedBox(
                        height: 15,
                      ),
                      AspectRatio(
                        aspectRatio: 1.5,
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[800],
                                  blurRadius: 10.0, // soften the shadow
                                  spreadRadius: 0, //extend the shadow
                                  offset: Offset(
                                    5.0, // Move to right 10  horizontally
                                    5.0, // Move to bottom 10 Vertically
                                  ),
                                ),
                              ],
                              borderRadius: BorderRadius.all(
                                Radius.circular(18),
                              ),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 18.0, left: 12.0, top: 24, bottom: 12),
                            child: FutureBuilder(
                                future: getCovidDetailsCountry(
                                    dropdownValueCountry),
                                builder: (context, details) {
                                  if (details.hasData) {
                                    return LineChart(
                                        mainData(details.data, true));
                                  }
                                  return Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.red,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.red.shade900),
                                    ),
                                  );
                                }),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FutureBuilder(
                          future: getCovidDetailsCountry(dropdownValueCountry),
                          builder: (context, details) {
                            if (details.hasData) {
                              return ReusableCovidCard(
                                covidmonths: details.data,
                                emptyMode: false,
                              );
                            }
                            return ReusableCovidCard(
                              covidmonths: details.data,
                              emptyMode: true,
                            );
                          }),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
