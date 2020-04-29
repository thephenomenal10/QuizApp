import 'package:flutter/material.dart';

Widget blueButton({BuildContext context, String label, buttonWidth}) {
    return new Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20.0),
        ),
        alignment: Alignment.center,
        width: buttonWidth != null ? buttonWidth : MediaQuery.of(context).size.width - 48,
        child: new Text(label,
            style: new TextStyle(color: Colors.white, fontSize: 20.0),
        ),
    );
}