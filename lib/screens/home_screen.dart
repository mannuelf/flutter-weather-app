import 'dart:core';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:weather_icons/weather_icons.dart';
import '../services/photos.dart';
import '../services/weather.dart';

import '../utilities/constants.dart';
import 'city_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {Key? key, required this.locationWeather, this.resizedPhotoURL})
      : super(key: key);

  // creates arguments for this class to pass data into it
  final locationWeather;
  final resizedPhotoURL;

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherModel weather = WeatherModel();
  PhotosModel photos = PhotosModel();
  int conditionNo = 0;
  int temperature = 0;
  String city = '';
  Widget weatherIcon = const Icon(WeatherIcons.refresh, size: 124.0);
  String weatherMessage = '';
  String condition = '';
  var customImg;

  @override
  void initState() {
    // widget is an abject that represents this class:
    // All props and methods attach to.
    // widget.someThing will access someThing on the object widget.
    super.initState();
    // pass gotten data to widget finally.
    updateUI(widget.locationWeather, widget.resizedPhotoURL);
  }

  // uses the variable from loading_screen
  void updateUI(dynamic weatherData, String resizedPhotoURL) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        city = 'No city';
        weatherIcon = const Icon(WeatherIcons.refresh, size: 132.0);
        weatherMessage = 'Unable to get weather';
        condition = '';
        customImg = 'images/city_bg_04.jpeg';
        return;
      }
      // anything Ui related "state" must be updated
      var conditionNo = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(conditionNo);

      city = weatherData['name'];

      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      weatherMessage = weather.getMessage(temperature);
      condition = weather.getWeatherConditionLabel(conditionNo);
      customImg = NetworkImage(resizedPhotoURL, scale: 0.8);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle uiButtonStyle = OutlinedButton.styleFrom(
      primary: Colors.white,
      minimumSize: const Size(64, 64),
      padding: const EdgeInsets.all(16),
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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: customImg,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$temperature',
                    style: kTempNumber,
                  ),
                  const Text(
                    '°',
                    style: kTempDegrees,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    city,
                    style: kCityLabelStyle,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  weatherIcon,
                  const SizedBox(
                    height: 42.0,
                  ),
                  Text(
                    condition,
                    style: kConditionLabelStyle,
                  )
                ],
              ),
              const SizedBox(
                height: 42.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    style: uiButtonStyle,
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const CityScreen();
                          },
                        ),
                      );
                      if (typedName != null) {
                        // get weather with the string
                        var weatherData =
                            await weather.getCityWeather(typedName);
                        var photoURL =
                            await photos.getPhotos([], weatherData['name']);
                        updateUI(weatherData, photoURL);
                      }
                    },
                    child: const Icon(Icons.search_rounded, size: 36),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  OutlinedButton(
                    style: uiButtonStyle,
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      var photoURL =
                          await photos.getPhotos([], weatherData['name']);
                      updateUI(weatherData, photoURL);
                    },
                    child: const Icon(Icons.refresh_rounded, size: 36),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(children: <Widget>[
                Link(
                  uri: Uri.parse('https://unsplash.com/@tianshu'),
                  builder: (context, followLink) => MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: followLink,
                      child: Text(
                        'Click me',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Text(
                  'Photo by artistName on Unsplash',
                  style: TextStyle(fontSize: 14),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
