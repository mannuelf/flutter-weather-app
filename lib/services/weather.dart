import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:whatsweatherdoing/services/location.dart';
import 'package:whatsweatherdoing/services/networking.dart';
import 'package:whatsweatherdoing/utilities/constants.dart';

const baseUrl = 'https://whatsweatherdoing.com';
const weatherPath = 'api/weather';
const cityPath = 'api/weather-city';
var url = '';
double lat = 0.0;
double lon = 0.0;

class WeatherModel {
  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    lat = location.latitude as double;
    lon = location.longitude as double;

    url = '$baseUrl/$weatherPath?lat=$lat&lon=$lon';
    NetworkHelper networkHelper = NetworkHelper(url);
    var decodedData = await networkHelper.getData();
    final weatherData = decodedData;

    return weatherData;
  }

  Future<dynamic> getCityWeather(String city) async {
    url = '$baseUrl/$cityPath/?city=$city';

    NetworkHelper networkHelper = NetworkHelper(url);
    var decodedData = await networkHelper.getData();
    final weatherData = decodedData;

    return weatherData;
  }

  Icon getWeatherIcon(int condition) {
    if (condition < 300) {
      return const Icon(WeatherIcons.thunderstorm, size: kWeatherIconSize);
    } else if (condition < 500) {
      return const Icon(WeatherIcons.rain_mix, size: kWeatherIconSize);
    } else if (condition < 600) {
      return const Icon(WeatherIcons.rain, size: kWeatherIconSize);
    } else if (condition < 700) {
      return const Icon(WeatherIcons.snowflake_cold, size: kWeatherIconSize);
    } else if (condition < 800) {
      return const Icon(WeatherIcons.day_haze, size: kWeatherIconSize);
    } else if (condition == 800) {
      return const Icon(WeatherIcons.day_sunny, size: kWeatherIconSize);
    } else if (condition <= 804) {
      return const Icon(WeatherIcons.day_cloudy, size: kWeatherIconSize);
    } else {
      return const Icon(WeatherIcons.refresh, size: kWeatherIconSize);
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
}
