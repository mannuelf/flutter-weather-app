import 'package:flutter/material.dart';
import 'package:http/http.dart' show Client, Response;

import '../services/location.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Client client = Client();

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  void deactivate() {
    super.deactivate();
    print('DEACTIVATED');
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    print(location.latitude);
    print(location.longitude);
    getWeatherData(location.latitude, location.longitude);
  }

  void getWeatherData(lat, lon) async {
    final root = 'https://api.openweathermap.org';

    final API_KEY = 'e14fe840c1768222dbc2a366f42b8909';
    Response response = await client.get(Uri.parse(
        '$root/data/2.5/weather?lat=35&lon=45&appid=e14fe840c1768222dbc2a366f42b8909'));
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
