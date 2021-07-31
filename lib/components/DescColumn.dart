import 'package:flutter/material.dart';

class DescColumn extends StatelessWidget {

  DescColumn({this.img,this.disease});
  final String img;
  final String disease;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 80.0,
          width: 80.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Image.asset(
            img,
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          disease,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ],
    );
  }
}

