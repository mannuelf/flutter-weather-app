import 'package:flutter/material.dart';
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

    NetworkHelper networkHelper = NetworkHelper();
    var decodedData =
        await networkHelper.getData(location.latitude, location.longitude);

    String city = decodedData['name'];
    double temperature = decodedData['main']['temp'];
    int conditionNo = decodedData['weather'][0]['id'];

    print('YIPEEEE');
    print(decodedData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
