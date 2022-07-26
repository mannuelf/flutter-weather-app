import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/networking.dart';

import '../services/location.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

var apiKey = dotenv.env['OPEN_WEATHER_API_KEY'];
const baseUrl = 'https://api.openweathermap.org';
const routes = 'data/2.5/weather';
const units = 'metric';
var url = '';

class WeatherModel {
  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    final query = 'lat=${location.latitude}&lon=${location.longitude}';

    url = '$baseUrl/$routes?$query&units=$units&appid=$apiKey';
    print('>>>URL>>>');
    print(url);
    NetworkHelper networkHelper = NetworkHelper(url);
    var decodedData = await networkHelper.getData();
    final weatherData = decodedData;

    return weatherData;
  }

  Future<dynamic> getCityWeather(String city) async {
    final query = 'q=$city';
    url = '$baseUrl/$routes?$query&units=$units&appid=$apiKey';

    NetworkHelper networkHelper = NetworkHelper(url);
    var decodedData = await networkHelper.getData();
    final weatherData = decodedData;

    return weatherData;
  }

  Widget getWeatherIcon(int condition) {
    print('getWeatherIcon');
    print(condition);
    if (condition < 300) {
      return Icon(Icons.graphic_eq, size: 90.0);
    } else if (condition < 400) {
      return Icon(Icons.shower, size: 90.0);
    } else if (condition < 600) {
      return Icon(Icons.shower, size: 90.0);
    } else if (condition < 700) {
      return Icon(Icons.snowing, size: 90.0);
    } else if (condition < 800) {
      return Icon(Icons.foggy, size: 90.0);
    } else if (condition == 800) {
      return Icon(Icons.sunny, size: 90.0);
    } else if (condition <= 804) {
      return Icon(Icons.cloud, size: 90.0);
    } else {
      return Icon(Icons.cancel, size: 90.0);
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
