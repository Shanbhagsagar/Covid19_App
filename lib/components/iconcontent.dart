import 'package:flutter/material.dart';
import '../constants.dart';

class ReusableIconContent extends StatelessWidget {
  ReusableIconContent({this.label,this.count, this.icoval});

  final String label;
  final String count;
  final IconData icoval;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Text(
          label,
          style: kSidebarStyle,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          count,
          style: kSidebarStyle,
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
