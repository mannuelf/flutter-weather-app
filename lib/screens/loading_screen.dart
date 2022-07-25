import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weatherapp/screens/location_screen.dart';
import 'package:weatherapp/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    // run the get location as soon as screen loads
    getLocationData();
  }

  @override
  void deactivate() {
    super.deactivate();
    print('DEACTIVATED');
  }

  void getLocationData() async {
    var sendWeatherData = null;
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getLocationWeather();
    print('🏝 >>>>LOADING_SCREEN: weatherData');
    print(weatherData);
    try {
      var sendWeatherData = weatherData;
    } catch (e) {
      print('>>>>LOADING_SCREEN: sendWeatherData');
      print(sendWeatherData);
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: sendWeatherData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 124,
        ),
      ),
    );
  }
}
