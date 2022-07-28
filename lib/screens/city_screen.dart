import 'package:flutter/material.dart';
import 'package:personalweather/utilities/constants.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  var city = '';
  int bgNum = 1;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle uiButtonStyle = OutlinedButton.styleFrom(
      primary: Colors.white,
      minimumSize: const Size(64, 64),
      padding: const EdgeInsets.all(0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      backgroundColor: Colors.white30,
    ).copyWith(
      side: MaterialStateProperty.resolveWith<BorderSide>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return BorderSide(
              style: BorderStyle.none,
              color: Theme.of(context).colorScheme.primary,
              width: 1,
            );
          }
          return BorderSide(
            style: BorderStyle.none,
            color: Theme.of(context).colorScheme.primary,
            width: 1,
          ); // Defer to the widget's default.
        },
      ),
    );

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_bg_01.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 42.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                TextField(
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter city name',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: OutlinedButton(
                      style: uiButtonStyle,
                      onPressed: () {
                        // pass data back to previous screen/or any screen
                        Navigator.pop(context, city);
                      },
                      child: const Icon(
                        Icons.search_outlined,
                        color: Color(kBrandBlue),
                        size: 42.0,
                      ),
                    ),
                  ),
                  onChanged: ((value) {
                    // assign value and pass value to weather module
                    city = value;
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
