import 'dart:convert';
import 'dart:io' show File;

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:unsplash_client/unsplash_client.dart';
import 'package:whatsweatherdoing/models/environment.dart';

class PhotosModel {
  var apiKey = dotenv.env['UNSPLASH_KEY'] ?? 'Key not found';
  var apiSecret = dotenv.env['UNSPLASH_SECRET'] ?? "Secret not found";
  final Map<String, String> _photoData = {};

  Future<Map<String, String>> getPhotos(List<String> args, String city) async {
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

    // Fetch 1 random photo matched with query by calling `goAndGet` to execute the [Request]
    // returned from `random` and throw an exception if the [Response] is not ok.
    try {
      final photos =
          await client.photos.random(count: 1, query: city).goAndGet();

      // See: [Unsplash docs](https://unsplash.com/documentation#track-a-photo-download)
      final downloadTracker =
          await client.photos.download(photos[0].id).goAndGet();
      //final onePhoto = await client.photos.get(photos[0].id).goAndGet();

      final artistName = photos.first.user.name;
      final artistUri = photos.first.user.links.html;
      final resizedUrl = photos.first.urls.regular.resizePhoto();

      _photoData.addAll({
        'artistName': artistName.toString(),
        'artistUri': artistUri.toString(),
        'downloadTracker': downloadTracker.toString(),
        'imageUri': resizedUrl.toString(),
      });

      client.close();
      return _photoData;
    } catch (e) {
      client.close();
      return {};
    }
  }
}

/// Loads [AppCredentials] from environment variables
/// (`UNSPLASH_ACCESS_KEY`, `UNSPLASH_SECRET_KEY`).
/// Returns `null` if the variables do not exist.
AppCredentials? loadAppCredentialsFromEnv() {
  return AppCredentials(
    accessKey: Environment.unsplashApiKey,
    secretKey: Environment.unsplashSecretKey,
  );
}

/// Loads [AppCredentials] from a json file with the given [fileName].
Future<AppCredentials> loadAppCredentialsFromFile(String fileName) async {
  final file = File(fileName);
  final content = await file.readAsString();
  final json = jsonDecode(content) as Map<String, dynamic>;
  return AppCredentials.fromJson(json);
}
