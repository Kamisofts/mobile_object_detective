import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:get/get.dart';

import '../../core/controllers/camera_controller.dart';
import '../../core/utils/injections.dart';
import 'detect_screen.dart';
import '../../core/models/models.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final cameraController = sl<DetectController>();


  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

  }

  loadModel(model) async {
    String? res;
    switch (model) {
      case yolo:
        res = await Tflite.loadModel(
          model: "assets/yolov2_tiny.tflite",
          labels: "assets/yolov2_tiny.txt",
        );
        break;

      case mobilenet:
        res = await Tflite.loadModel(
            model: "assets/mobilenet_v1_1.0_224.tflite",
            labels: "assets/mobilenet_v1_1.0_224.txt");
        break;

      case posenet:
        res = await Tflite.loadModel(
            model: "assets/posenet_mv1_075_float_from_checkpoints.tflite");
        break;

      default:
        res = await Tflite.loadModel(
            model: "assets/ssd_mobilenet.tflite",
            labels: "assets/ssd_mobilenet.txt");
    }
    log("$res");
  }

  onSelect(model) {
    loadModel(model);
    final route = MaterialPageRoute(builder: (context) {
      return DetectScreen( model: model,);
    });
    Navigator.of(context).push(route);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            ElevatedButton(
              child: const Text(ssd),
              onPressed: () => onSelect(ssd),
            ),
            ElevatedButton(
              child: const Text(yolo),
              onPressed: () => onSelect(yolo),
            ),
            ElevatedButton(
              child: const Text(mobilenet),
              onPressed: () => onSelect(mobilenet),
            ),
            ElevatedButton(
              child: const Text(posenet),
              onPressed: () => onSelect(posenet),
            ),
          ],
        ),
      ),
    );
  }
}
