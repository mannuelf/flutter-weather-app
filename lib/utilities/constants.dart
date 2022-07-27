import 'package:flutter/material.dart';

const kTempNumber = TextStyle(
  fontFamily: 'Ubuntu',
  fontSize: 192.0,
  fontWeight: FontWeight.w300,
);

const kTempDegrees = TextStyle(
  fontFamily: 'Ubuntu',
  fontSize: 192.0,
  fontWeight: FontWeight.w600,
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

const kCityLabelStyle = TextStyle(
  fontFamily: 'Ubuntu',
  fontSize: 32.0,
  fontWeight: FontWeight.bold,
);

const kConditionLabelStyle = TextStyle(
  fontFamily: 'Ubuntu',
  fontSize: 20.0,
  fontWeight: FontWeight.w300,
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
