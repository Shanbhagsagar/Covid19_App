import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard({this.colour, this.cardChild});

  final Color colour;
  final Widget cardChild;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: cardChild,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: colour,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}

class ReusableHospitalCard extends StatelessWidget {
  ReusableHospitalCard(
      {this.hospitalName,
      this.hospitalAddress,
      this.hospitalPhone,
      this.hospitalUrl});

  final String hospitalName;
  final String hospitalAddress;
  final String hospitalPhone;
  final String hospitalUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '$hospitalName',
                style: TextStyle(
                  fontFamily: 'RobotoSlab',
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            'Address: $hospitalAddress',
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontFamily: 'RobotoSlab',
              fontWeight: FontWeight.w200,
              fontSize: 15.0,
              color: Colors.grey[900],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'Phone: $hospitalPhone',
            style: TextStyle(
              fontFamily: 'RobotoSlab',
              fontWeight: FontWeight.w700,
              fontSize: 15.0,
              color: Colors.grey[700],
            ),
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
                  color: Colors.blue[800],
                  borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                      shape: CircleBorder(),
                      minWidth: 120.0,
                      height: 42.0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.directions,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            'Directions',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.0,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        launch('$hospitalUrl');
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
                          SizedBox(width: 10.0),
                          Text(
                            'Call',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.0,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        launch('tel:+$hospitalPhone');
                      }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ReusableCovidCard extends StatelessWidget {
  ReusableCovidCard({this.covidmonths, this.emptyMode});

  final covidmonths;
  final bool emptyMode;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DataTable(
        columnSpacing: 45,
        dataRowHeight: 50,
        columns: [
          DataColumn(
              label: Text(
            'Confirmed',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'RobotoSlab',
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
              color: Colors.red[800],
            ),
          )),
          DataColumn(
              label: Text(
            'Recovered',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'RobotoSlab',
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
              color: Colors.green[800],
            ),
          )),
          DataColumn(
              label: Text(
            'Deceased',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'RobotoSlab',
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
              color: Colors.grey[800],
            ),
          )),
        ],
        rows: [
          DataRow(cells: [
            DataCell(Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                emptyMode ? '' : covidmonths.totalConfirmed.round().toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'RobotoSlab',
                  fontWeight: FontWeight.w500,
                  fontSize: 12.0,
                  color: Colors.black,
                ),
              ),
            )),
            DataCell(Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                emptyMode ? '' : covidmonths.totalRecovered.round().toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'RobotoSlab',
                  fontWeight: FontWeight.w500,
                  fontSize: 13.0,
                  color: Colors.black,
                ),
              ),
            )),
            DataCell(Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                emptyMode ? '' : covidmonths.totalDeceased.round().toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'RobotoSlab',
                  fontWeight: FontWeight.w500,
                  fontSize: 13.0,
                  color: Colors.black,
                ),
              ),
            )),
          ]),
        ],
      ),
    );
  }
}

class ReusableStateCovidCard extends StatelessWidget {
  ReusableStateCovidCard(
      {this.covidmonths, this.emptyMode, this.dropdownValue});

  final covidmonths;
  final bool emptyMode;
  final String dropdownValue;

  @override
  Widget build(BuildContext context) {

    var rawData;
    try {
      rawData = covidmonths.stateMap[dropdownValue].split(" ");
    } catch (e) {
      throw e;
    }
    return Container(
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DataTable(
        columnSpacing: 45,
        dataRowHeight: 50,
        columns: [
          DataColumn(
              label: Text(
            'Confirmed',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'RobotoSlab',
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
              color: Colors.red[800],
            ),
          )),
          DataColumn(
              label: Text(
            'Recovered',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'RobotoSlab',
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
              color: Colors.green[800],
            ),
          )),
          DataColumn(
              label: Text(
            'Deceased',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'RobotoSlab',
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
              color: Colors.grey[800],
            ),
          )),
        ],
        rows: [
          DataRow(cells: [
            DataCell(Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                emptyMode ? '' : rawData[0],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'RobotoSlab',
                  fontWeight: FontWeight.w500,
                  fontSize: 12.0,
                  color: Colors.black,
                ),
              ),
            )),
            DataCell(Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                emptyMode ? '' : rawData[1],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'RobotoSlab',
                  fontWeight: FontWeight.w500,
                  fontSize: 13.0,
                  color: Colors.black,
                ),
              ),
            )),
            DataCell(Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                emptyMode ? '' : rawData[2],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'RobotoSlab',
                  fontWeight: FontWeight.w500,
                  fontSize: 13.0,
                  color: Colors.black,
                ),
              ),
            )),
          ]),
        ],
      ),
    );
  }
}
