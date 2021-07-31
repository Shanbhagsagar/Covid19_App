import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:covid_19/components/reusablecard.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'covid_model.dart';
import 'iconcontent.dart';

LineChartData mainData(dynamic covidmonths, bool isDynamic){
   List<Color> activeGradientColors = [
     Colors.red,
   ];
   List<Color> recoveredGradientColors = [
     Colors.green,
   ];
   List<Color> deceasedGradientColors = [
     Colors.black,
   ];

  return LineChartData(
    gridData: FlGridData(
      show: true,
      drawVerticalLine: true,
      drawHorizontalLine: true,
    ),
    titlesData: FlTitlesData(
      show: true,
      bottomTitles: SideTitles(
        showTitles: true,
        reservedSize: 15,
        textStyle: const TextStyle(
            color: Color(0xff68737d),
            fontWeight: FontWeight.bold,
            fontSize: 12),
        getTitles: (value) {
          switch (value.toInt()) {
            case 0:
              return 'Jan';
            case 1:
              return 'Feb';
            case 2:
              return 'Mar';
            case 3:
              return 'Apr';
            case 4:
              return 'May';
            case 5:
              return 'Jun';
            case 6:
              return 'Jul';
            case 7:
              return 'Aug';
            case 8:
              return 'Sep';
            case 9:
              return 'Oct';
            case 10:
              return 'Nov';
            case 11:
              return 'Dec';
          }
          return '';
        },
        margin: 5,
      ),
      leftTitles: SideTitles(
        showTitles: true,
        textStyle: const TextStyle(
          color: Color(0xff67727d),
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
        getTitles: isDynamic?(value){
          switch (value.toInt()) {
            case 0:
              return '0';
            case 1000:
              return '1k';
            case 2000:
              return '2k';
            case 5000:
              return '5k';
            case 10000:
              return '10k';
            case 20000:
              return '20k';
            case 50000:
              return '50k';
            case 100000:
              return '100k';
            case 200000:
              return '200k';
            case 500000:
              return '500k';
            case 1000000:
              return '1M';
            case 2000000:
              return '2M';
            case 3000000:
              return '3M';
          }
          return '';
        }:(value) {
          switch (value.toInt()) {
            case 0:
              return '0';
            case 1000000:
              return '1M';
            case 2000000:
              return '2M';
            case 3000000:
              return '3M';
          }
          return '';
        },
        reservedSize: 15,
        margin: 12,
      ),
    ),
    borderData: FlBorderData(
        show: false,
        border: Border.all(color: const Color(0xff37434d), width: 1)),
    minX: 0,
    maxX: 11,
    minY: 0,
    maxY: isDynamic?covidmonths.totalConfirmed:3000000,
    lineBarsData: [
      LineChartBarData(
        spots: [
          FlSpot(0, covidmonths.confirmedJan),
          FlSpot(1, covidmonths.confirmedFeb),
          FlSpot(2, covidmonths.confirmedMar),
          FlSpot(3, covidmonths.confirmedApr),
          FlSpot(4, covidmonths.confirmedMay),
          FlSpot(5, covidmonths.confirmedJun),
          FlSpot(6, covidmonths.confirmedJul),
          FlSpot(7, covidmonths.confirmedAug),
          FlSpot(8, covidmonths.confirmedSep),
          FlSpot(9, covidmonths.confirmedOct),
          FlSpot(10, covidmonths.confirmedNov),
          FlSpot(11, covidmonths.confirmedDec),
        ],
        isCurved: true,
        curveSmoothness: 0.1,
        colors: activeGradientColors,
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: false,
          colors: activeGradientColors
              .map((color) => color.withOpacity(0.3))
              .toList(),
        ),
      ),
      LineChartBarData(
        spots: [
          FlSpot(0, covidmonths.recoveredJan),
          FlSpot(1, covidmonths.recoveredFeb),
          FlSpot(2, covidmonths.recoveredMar),
          FlSpot(3, covidmonths.recoveredApr),
          FlSpot(4, covidmonths.recoveredMay),
          FlSpot(5, covidmonths.recoveredJun),
          FlSpot(6, covidmonths.recoveredJul),
          FlSpot(7, covidmonths.recoveredAug),
          FlSpot(8, covidmonths.recoveredSep),
          FlSpot(9, covidmonths.recoveredOct),
          FlSpot(10, covidmonths.recoveredNov),
          FlSpot(11, covidmonths.recoveredDec),
        ],
        isCurved: true,
        curveSmoothness: 0.1,
        colors: recoveredGradientColors,
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: false,
          colors: recoveredGradientColors
              .map((color) => color.withOpacity(0.3))
              .toList(),
        ),
      ),
      LineChartBarData(
        spots: [
          FlSpot(0, covidmonths.deceasedJan),
          FlSpot(1, covidmonths.deceasedFeb),
          FlSpot(2, covidmonths.deceasedMar),
          FlSpot(3, covidmonths.deceasedApr),
          FlSpot(4, covidmonths.deceasedMay),
          FlSpot(5, covidmonths.deceasedJun),
          FlSpot(6, covidmonths.deceasedJul),
          FlSpot(7, covidmonths.deceasedAug),
          FlSpot(8, covidmonths.deceasedSep),
          FlSpot(9, covidmonths.deceasedOct),
          FlSpot(10, covidmonths.deceasedNov),
          FlSpot(11, covidmonths.deceasedDec),
        ],
        isCurved: true,
        curveSmoothness: 0.1,
        colors: deceasedGradientColors,
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: false,
          colors: deceasedGradientColors
              .map((color) => color.withOpacity(0.3))
              .toList(),
        ),
      ),
    ],
  );
}


class TotalStatus extends StatelessWidget {
  const TotalStatus({
    Key key,
    @required this.covidmonths,
    @required this.emptyMode,
  }) : super(key: key);

  final covidmonths;
  final bool emptyMode;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: ReusableCard(
            colour: Colors.white,
            cardChild: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ReusableIconContent(
                label: 'Confirmed',
                count: emptyMode
                    ? ''
                    : covidmonths.totalConfirmed.round().toString(),
              ),
            ),
          ),
        ),
        Expanded(
          child: ReusableCard(
            colour: Colors.greenAccent,
            cardChild: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ReusableIconContent(
                label: 'Recovered',
                count: emptyMode
                    ? ''
                    : covidmonths.totalRecovered.round().toString(),
              ),
            ),
          ),
        ),
        Expanded(
          child: ReusableCard(
            colour: Colors.white,
            cardChild: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ReusableIconContent(
                label: 'Deceased',
                count: emptyMode
                    ? ''
                    : covidmonths.totalDeceased.round().toString(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


class TotalStatusCountry extends StatelessWidget {
  const TotalStatusCountry({
    Key key,
    @required this.covidmonths,
    @required this.emptyMode,
  }) : super(key: key);

  final covidmonths;
  final bool emptyMode;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: ReusableCard(
            colour: Colors.redAccent[200],
            cardChild: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ReusableIconContent(
                label: 'Confirmed',
                count: emptyMode
                    ? ''
                    : covidmonths.totalConfirmed.round().toString(),
              ),
            ),
          ),
        ),
        Expanded(
          child: ReusableCard(
            colour: Colors.greenAccent,
            cardChild: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ReusableIconContent(
                label: 'Recovered',
                count: emptyMode
                    ? ''
                    : covidmonths.totalRecovered.round().toString(),
              ),
            ),
          ),
        ),
        Expanded(
          child: ReusableCard(
            colour: Colors.white,
            cardChild: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ReusableIconContent(
                label: 'Deceased',
                count: emptyMode
                    ? ''
                    : covidmonths.totalDeceased.round().toString(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


class TotalStatusStately extends StatelessWidget {
  const TotalStatusStately({
    Key key,
    @required this.covidstates,
    @required this.emptyMode,
    @required this.dropdownValue,
    this.context,
  }) : super(key: key);

  final covidstates;
  final bool emptyMode;
  final String dropdownValue;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    var rawData;
    try {
      rawData = covidstates.stateMap[dropdownValue].split(" ");
    } catch (e) {
      throw e;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ReusableCard(
          colour: Colors.redAccent[200],
          cardChild: Padding(
            padding: const EdgeInsets.all(4.0),
            child: ReusableIconContent(
              label: 'Confirmed',
              count: emptyMode ? '' : rawData[0],
            ),
          ),
        ),
        ReusableCard(
          colour: Colors.greenAccent,
          cardChild: Padding(
            padding: const EdgeInsets.all(4.0),
            child: ReusableIconContent(
              label: 'Recovered',
              count: emptyMode ? '' : rawData[1],
            ),
          ),
        ),
        ReusableCard(
          colour: Colors.white,
          cardChild: Padding(
            padding: const EdgeInsets.all(4.0),
            child: ReusableIconContent(
              label: 'Deceased',
              count: emptyMode ? '' : rawData[2],
            ),
          ),
        ),
      ],
    );
  }
}

Future<CovidModelDaily> getCovidDetailsDaily() async {
  final urlDaily = "https://api.covid19india.org/data.json";
  final responseDaily = await http.get(urlDaily);
  if (responseDaily.statusCode == 200) {
    LinkedHashMap rawdataDaily = jsonDecode(responseDaily.body);
    final covidSummaryDaily = rawdataDaily["cases_time_series"];
    return CovidModelDaily.covidTotal(covidSummaryDaily);
  } else {
    throw Exception();
  }
}

Future<CovidModelStately> getCovidDetailsState() async {
  final urlDaily = "https://api.covid19india.org/data.json";
  final responseDaily = await http.get(urlDaily);
  if (responseDaily.statusCode == 200) {
    LinkedHashMap rawdataDaily = jsonDecode(responseDaily.body);
    final covidSummaryState = rawdataDaily["statewise"];
    return CovidModelStately.covidTotalState(covidSummaryState);
  } else {
    throw Exception();
  }
}


Future<CovidModelCountry> getCovidDetailsCountry(String country) async {
  final url = "https://pomber.github.io/covid19/timeseries.json";
  final response = await http.get(url);
  if (response.statusCode == 200) {
    LinkedHashMap rawdata = jsonDecode(response.body);
    return CovidModelCountry.covidTotalCountry(rawdata,country);
  } else {
    throw Exception();
  }
}

Future<CovidModelCountry> getCovidDetailsCountryList() async {
  final url = "https://pomber.github.io/covid19/timeseries.json";
  final response = await http.get(url);
  if (response.statusCode == 200) {
    LinkedHashMap rawdata =jsonDecode(response.body);
    return CovidModelCountry.covidTotalCountryList(rawdata);
  } else {
    throw Exception();
  }
}

LinkedHashMap parseJson(String responseBody){
  return json.decode(responseBody);
}
