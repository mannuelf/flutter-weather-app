import 'package:flutter/material.dart';
import '../screens/city_screen.dart';
import '../services/weather.dart';

import '../utilities/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.locationWeather}) : super(key: key);

  // creates arguments for this class to pass data into it
  final locationWeather;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherModel weather = WeatherModel();
  int conditionNo = 0;
  int temperature = 0;
  String city = '';
  Widget weatherIcon = Icon(Icons.shower, size: 90.0);
  String weatherMessage = '';

  @override
  void initState() {
    // widget is an abject that represents this class:
    // All props and methods attach to.
    // widget.someThing will access someThing on the object widget.
    super.initState();
    // pass gotten data to widget finally.
    updateUI(widget.locationWeather);
  }

  // uses the variable from loading_screen
  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        city = '';
        weatherIcon = Icon(Icons.close, size: 90.0);
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpeg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Row(
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
                  ),
                  weatherIcon,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
