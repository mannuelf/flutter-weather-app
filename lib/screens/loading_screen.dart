import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:whatsweatherdoing/services/photos.dart';
import 'package:whatsweatherdoing/services/weather.dart';
import 'package:whatsweatherdoing/utilities/constants.dart';

import 'home_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
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
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getLocationData() async {
    WeatherModel weatherModel = WeatherModel();
    final weatherData = await weatherModel.getLocationWeather();

    PhotosModel photosModel = PhotosModel();
    String city = weatherData['name'];
    final photoData = await photosModel.getPhotos([], city);

    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return HomeScreen(
            locationWeather: weatherData,
            photoData: photoData,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(kBrandBlue),
      body: Center(
        child: SpinKitFadingCube(
          color: Colors.amber,
          size: 124,
        ),
      ),
    );
  }
}
