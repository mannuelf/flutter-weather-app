import 'dart:convert';
import 'dart:io' show File;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:unsplash_client/unsplash_client.dart';

class PhotosModel {
  var apiKey = dotenv.env['UNSPLASH_KEY'];
  var apiSecret = dotenv.env['UNSPLASH_SECRET'];

  Future<String> getPhotos(List<String> args, String city) async {
    // Load app credentials from environment variables or file.
    var appCredentials = loadAppCredentialsFromEnv();

    if (appCredentials == null) {
      if (args.length != 1) {
        throw 'Please provide a credentials file as the first and only argument.';
      }

      appCredentials = await loadAppCredentialsFromFile(args.first);
    }

    // Create a client.
    final client = UnsplashClient(
      settings: ClientSettings(credentials: appCredentials),
    );

    // Fetch 5 random photos by calling `goAndGet` to execute the [Request]
    // returned from `random` and throw an exception if the [Response] is not ok.
    final photos = await client.photos.random(count: 1, query: city).goAndGet();
    print('photos.dart');
    print(photos[0].id);
    print('----\n');
    final userData = await client.photos.download(photos[0].id).goAndGet();
    final onePhoto = await client.photos.get(photos[0].id).goAndGet();
    print('photos.dart: userData');
    print(userData);
    print('----\n');

    // Create a dynamically resizing url.
    final resizedUrl = photos.first.urls.regular.resizePhoto();
    final firstName = photos.first.user.firstName.toString();
    final lastName = photos.first.user.lastName.toString();
    print('photos.dart: firstName');
    print(firstName);
    print(lastName);
    print('----\n');
    // Close the client when it is done being used to clean up allocated
    // resources.
    client.close();
    return resizedUrl.toString();
  }

  void getUserData(){}
}

/// Loads [AppCredentials] from environment variables
/// (`UNSPLASH_ACCESS_KEY`, `UNSPLASH_SECRET_KEY`).
/// Returns `null` if the variables do not exist.
AppCredentials? loadAppCredentialsFromEnv() {
  // final accessKey = Platform.environment['UNSPLASH_KEY'];
  // final secretKey = Platform.environment['UNSPLASH_SECRET'];
  // print('Platform.environment');
  // print(Platform.environment);
  // if (accessKey != null && secretKey != null) {
  //
  // }
  return const AppCredentials(
    accessKey: "xUfS-tzZhGl3J502cH6FK5yvYoygImC8Wox6vfr15xU",
    secretKey: "LoJn3r7tMlma8apEtOAJEejGA-i7pxVN_UCMmIb2c-g",
  );
  ;
}

/// Loads [AppCredentials] from a json file with the given [fileName].
Future<AppCredentials> loadAppCredentialsFromFile(String fileName) async {
  final file = File(fileName);
  final content = await file.readAsString();
  final json = jsonDecode(content) as Map<String, dynamic>;
  return AppCredentials.fromJson(json);
}
