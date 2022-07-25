import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weatherapp/screens/location_screen.dart';
import 'package:weatherapp/services/networking.dart';

import '../services/location.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  @override
  void deactivate() {
    super.deactivate();
    print('DEACTIVATED');
  }

  void getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();

    const baseUrl = 'https://api.openweathermap.org';
    const routes = 'data/2.5/weather';
    final query = 'lat=${location.latitude}&lon=${location.longitude}';
    const apiKey = 'e14fe840c1768222dbc2a366f42b8909';

    final url = '$baseUrl/$routes?$query&appid=$apiKey';

    NetworkHelper networkHelper = NetworkHelper(url);
    var decodedData = await networkHelper.getData();

    String city = decodedData['name'];
    double temperature = decodedData['main']['temp'];
    int conditionNo = decodedData['weather'][0]['id'];

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const LocationScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: const Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 124,
        ),
      ),
    );
  }
}
