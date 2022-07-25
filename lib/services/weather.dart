import 'package:weatherapp/services/networking.dart';

import '../services/location.dart';

const apiKey = 'e14fe840c1768222dbc2a366f42b8909';
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

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
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
