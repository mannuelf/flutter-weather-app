import 'package:alert/alert.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      Alert(message: 'Turn on location services to use this app, please.')
          .show();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    } else {
      print('<<<❌ Error>>>');
      // throw Exception('Error');
    }
    if (permission == LocationPermission.whileInUse) {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.medium);
        latitude = position.latitude;
        longitude = position.longitude;
      } catch (e) {
        Alert(message: 'Turn on location services to use this app').show();
      }
    }
  }
}
