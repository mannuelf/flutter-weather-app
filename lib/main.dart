import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:whatsweatherdoing/models/environment.dart';

import 'screens/loading_screen.dart';

Future<void> main() async {
  await dotenv.load(fileName: Environment.fileName);
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const LoadingScreen(),
    );
  }
}
