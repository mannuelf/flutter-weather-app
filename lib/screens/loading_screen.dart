import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:personalweather/services/photos.dart';
import '../utilities/constants.dart';
import '../services/weather.dart';
import 'home_screen.dart';

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
  }

  void getLocationData() async {
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getLocationWeather();
    PhotosModel photosModel = PhotosModel();
    var photoURL = await photosModel.getPhotos([], 'cupertino');
    print('>>>>> photoURL');
    print(photoURL);

    // ignore: use_build_context_synchronously
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return HomeScreen(
        locationWeather: weatherData,
        resizedPhotoURL: photoURL,
      );
    }));
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
