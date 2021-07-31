import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {

  RoundedButton({this.colour,this.title,this.onPressed});
  final Color colour;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(20),
        child: MaterialButton(
            minWidth: 250.0,
            height: 42.0,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.0,
              ),
            ),
            onPressed: onPressed),
      ),
    );
  }
}

class SmallRoundedButton extends StatelessWidget {

  SmallRoundedButton({this.colour,this.title,this.onPressed,this.icon});
  final Color colour;
  final String title;
  final Function onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      child: Material(
        color: colour,
        borderRadius: BorderRadius.circular(25),
        child: MaterialButton(
            shape: CircleBorder(),
            child: Container(
              width: 76,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    icon,
                    size: 20,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),
            onPressed: onPressed),
      ),
    );
  }
}

