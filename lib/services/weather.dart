import '../services/location.dart';
import 'package:weatherapp/services/networking.dart';

class WeatherModel {
  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    const baseUrl = 'https://api.openweathermap.org';
    const routes = 'data/2.5/weather';
    final query = 'lat=${location.latitude}&lon=${location.longitude}';
    const units = 'metric';
    const apiKey = 'e14fe840c1768222dbc2a366f42b8909';

    final url = '$baseUrl/$routes?$query&units=$units&appid=$apiKey';

    NetworkHelper networkHelper = NetworkHelper(url);
    var decodedData = await networkHelper.getData();
    final weatherData = decodedData;
    print('weather.dart');
    print(weatherData);
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
