import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get fileName {
    if (kReleaseMode) {
      return '.env.production';
    }

    return '.env';
  }

  static String get openWeatherApiKey {
    return dotenv.env['OPEN_WEATHER_API_KEY'] ??
        'OPEN_WEATHER_API_KEY not found';
  }

  static String get unsplashApiKey {
    return dotenv.env['UNSPLASH_KEY'] ?? 'OPEN_WEATHER_API_KEY not found';
  }

  static String get unsplashSecretKey {
    return dotenv.env['UNSPLASH_SECRET'] ?? 'OPEN_WEATHER_API_KEY not found';
  }

  static String get whatsWeatherDoingApiUrl {
    return dotenv.env['WHATSWEATHERDOING_API_URL'] ??
        'WHATSWEATHERDOING_API_URL not found';
  }
}
