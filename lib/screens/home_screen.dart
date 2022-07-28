import 'dart:core';

import 'package:flutter/material.dart';
import 'package:personalweather/services/photos.dart';
import 'package:personalweather/services/weather.dart';
import 'package:personalweather/utilities/constants.dart';
import 'package:url_launcher/link.dart';
import 'package:weather_icons/weather_icons.dart';

import 'city_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {Key? key, required this.locationWeather, required this.photoData})
      : super(key: key);

  // creates arguments for this class to pass data into it
  final locationWeather;
  final photoData;

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PhotosModel photos = PhotosModel();
  WeatherModel weather = WeatherModel();

  int conditionNo = 0;
  int temperature = 0;
  Map<String, String> _photoData = {};
  String artistName = '';
  String artistUri = '';
  String city = '';
  String condition = '';
  String fallbackUri = 'images/city_bg_01.jpeg';
  String imageUri = '';
  String weatherMessage = '';
  var customImg;
  Widget weatherIcon = const Icon(WeatherIcons.refresh, size: 124.0);

  @override
  void initState() {
    // widget is an abject that represents this class:
    // All props and methods attach to.
    // widget.someThing will access someThing on the object widget.
    super.initState();
    // pass gotten data to widget finally.
    updateUI(widget.locationWeather, widget.photoData);
  }

  // uses the variable from loading_screen
  void updateUI(dynamic weatherData, Map<String, String> photoData) {
    setState(() {
      if (weatherData == null) {
        city = 'No city';
        condition = '';
        temperature = 0;
        weatherIcon = const Icon(WeatherIcons.refresh, size: 132.0);
        weatherMessage = 'Unable to get weather';
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

      _photoData = photoData;
      artistUri = _photoData['artistUri'].toString();
      artistName = _photoData['artistName'].toString();

      imageUri = _photoData['imageUri'].toString();
      if (imageUri == null) {
        customImg = NetworkImage(fallbackUri, scale: 0.8);
      }
      customImg = NetworkImage(imageUri, scale: 0.3);
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

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: customImg,
              fit: BoxFit.cover,
            ),
          ),
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
                        var weatherData =
                            await weather.getCityWeather(typedName);
                        var photoData =
                            await photos.getPhotos([], weatherData['name']);
                        updateUI(weatherData, photoData);
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
                      var photoData =
                          await photos.getPhotos([], weatherData['name']);
                      updateUI(weatherData, photoData);
                    },
                    child: const Icon(Icons.refresh_rounded, size: 36),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Photo by: ',
                      style: TextStyle(fontSize: 16),
                    ),
                    Link(
                      uri: Uri.parse(artistUri),
                      target: LinkTarget.blank,
                      builder: (context, followLink) => MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: followLink,
                          child: Text(
                            artistName,
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                              decorationStyle: TextDecorationStyle.solid,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      ' on Unsplash',
                      style: TextStyle(fontSize: 16),
                    ),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}
