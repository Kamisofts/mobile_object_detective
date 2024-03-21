import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'ui/screens/home.dart';
import 'core/utils/injections.dart' as di;

late List<CameraDescription> cameras;

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'tflite real-time detection',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: const HomePage(),
    );
  }
}
