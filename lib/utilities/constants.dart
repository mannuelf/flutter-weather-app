import 'package:flutter/material.dart';

const kBrandBlue = 0xFF073B4C;
const kBrandLightBlue = 0xFF118AB2;
const kBrandGreen = 0xFF06D6A0;
const kBrandYellow = 0xFFFFD166;
const kBrandPink = 0xFFEF476F;

const kTempNumber = TextStyle(
  fontFamily: 'Ubuntu',
  fontSize: 192.0,
  fontWeight: FontWeight.w300,
);

const kTempDegrees = TextStyle(
  fontFamily: 'Ubuntu',
  fontSize: 192.0,
  fontWeight: FontWeight.w400,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Ubuntu',
  fontSize: 34.0,
);

const kButtonTextStyle = TextStyle(
  fontFamily: 'Ubuntu',
  fontSize: 26.0,
);

const kUiButtonStyle = TextStyle(
    fontFamily: 'Ubuntu', fontSize: 22.0, fontWeight: FontWeight.normal);

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
  fontSize: 22.0,
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

// Buttons
