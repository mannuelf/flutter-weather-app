import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

import '../services/networking.dart';

import '../services/location.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

var apiKey = dotenv.env['OPEN_WEATHER_API_KEY'];
const baseUrl = 'https://api.openweathermap.org';
const weatherRoute = 'data/2.5/weather';
const units = 'metric';
var url = '';

class WeatherModel {
  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    final query = 'lat=${location.latitude}&lon=${location.longitude}';
    url = '$baseUrl/$weatherRoute?$query&units=$units&appid=$apiKey';

    NetworkHelper networkHelper = NetworkHelper(url);
    var decodedData = await networkHelper.getData();
    final weatherData = decodedData;

    return weatherData;
  }

  Future<dynamic> getCityWeather(String city) async {
    final query = 'q=$city';
    url = '$baseUrl/$weatherRoute?$query&units=$units&appid=$apiKey';

    NetworkHelper networkHelper = NetworkHelper(url);
    var decodedData = await networkHelper.getData();
    final weatherData = decodedData;

    return weatherData;
  }

  Icon getWeatherIcon(int condition) {
    if (condition < 300) {
      return const Icon(WeatherIcons.thunderstorm, size: 132.0);
    } else if (condition < 500) {
      return const Icon(WeatherIcons.rain_mix, size: 132.0);
    } else if (condition < 600) {
      return const Icon(WeatherIcons.rain, size: 132.0);
    } else if (condition < 700) {
      return const Icon(WeatherIcons.snowflake_cold, size: 132.0);
    } else if (condition < 800) {
      return const Icon(WeatherIcons.day_haze, size: 132.0);
    } else if (condition == 800) {
      return const Icon(WeatherIcons.day_sunny, size: 132.0);
    } else if (condition <= 804) {
      return const Icon(WeatherIcons.day_cloudy, size: 132.0);
    } else {
      return const Icon(WeatherIcons.refresh, size: 132.0);
    }
  }

  String getWeatherConditionLabel(int condition) {
    if (condition < 300) {
      return 'Thunderstorm';
    } else if (condition < 500) {
      return 'Drizzle';
    } else if (condition < 600) {
      return 'Raining';
    } else if (condition < 700) {
      return 'Light snow';
    } else if (condition < 800) {
      return 'Mist | Haze | Dust';
    } else if (condition == 800) {
      return 'Sunny';
    } else if (condition <= 804) {
      return 'Few clouds';
    } else {
      return 'Refresh';
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
