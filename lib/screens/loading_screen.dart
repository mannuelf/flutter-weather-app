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

    NetworkHelper networkHelper = NetworkHelper();
    var gotData =
        await networkHelper.getData(location.latitude, location.longitude);
    // double temperature = decodedData(data)['main']['temp'];
    // int conditionNo = decodedData(data)['weather'][0]['id'];

    print('YIPEEEE');
    print(gotData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
