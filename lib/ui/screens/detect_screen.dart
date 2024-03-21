import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../core/utils/injections.dart';
import '../widgets/bndbox.dart';
import '../widgets/camera.dart';
import '../../core/controllers/camera_controller.dart';

class DetectScreen extends StatefulWidget {
  final String model;

  const DetectScreen({super.key, required this.model});

  @override
  State<DetectScreen> createState() => _DetectScreenState();
}

class _DetectScreenState extends State<DetectScreen> {
  List<CameraDescription>? cameras;
  List<dynamic>? _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  bool isLoaded = false;

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    await setupCameras();
  }

  setupCameras() async {
    try {
      cameras = await availableCameras();
      setState(() {
        isLoaded=true;
      });
    } on CameraException catch (e) {}
  }

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    setupCameras();
  }

  final cameraController = sl<DetectController>();

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.sizeOf(context);
    return Scaffold(
        body: !isLoaded
            ? SizedBox.shrink()
            : Stack(
                children: [
                  Camera(cameras!, widget.model, setRecognitions, 0),
                  BndBox(
                      _recognitions ?? [],
                      math.max(_imageHeight, _imageWidth),
                      math.min(_imageHeight, _imageWidth),
                      screen.height,
                      screen.width,
                      widget.model),
                  Positioned(
                    bottom: 30,
                    right: 30,
                    child: IconButton(
                      icon: const Icon(Icons.flip_camera_ios_outlined,size: 50,),
                      onPressed: () async {
                        cameraController.toggleCamera();

                        setState(() {
                          isLoaded=false;
                        });
                        await setupCameras();
                        // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                        //   return DetectScreen( model: widget.model,);
                        // }));
                      },
                    ),
                  )
                ],
              ));
  }
}
