import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Ubuntu',
  fontSize: 132.0,
  fontWeight: FontWeight.bold,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Ubuntu',
  fontSize: 34.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 26.0,
  fontFamily: 'Ubuntu',
);

const kConditionTextStyle = TextStyle(
  fontSize: 60.0,
);

const kTextInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(Icons.location_city),
  hintText: 'Enter city name',
  hintStyle: TextStyle(color: Colors.grey),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide.none,
  ),
);
