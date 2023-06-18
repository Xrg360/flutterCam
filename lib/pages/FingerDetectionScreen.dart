import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:async';

class FingerDetectionScreen extends StatefulWidget {
  @override
  _FingerDetectionScreenState createState() => _FingerDetectionScreenState();
}

class _FingerDetectionScreenState extends State<FingerDetectionScreen> {
  late CameraController _cameraController;
  CameraImage? _savedImage;
  int _numberOfFingers = 0;
  bool _isFrontCamera = true;
  Timer? _gestureTimer;
  int _gestureDisplayDuration =
      5; // Display duration for each gesture in seconds
  int _currentGestureIndex = 0; // Index of the current gesture
  List<String> _gestureAssets = [
    'assets/images/gesture1.png',
    'assets/images/gesture2.png',
    // Add more gesture assets as needed
  ];

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _startGestureTimer();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    _cameraController = CameraController(
      _isFrontCamera ? cameras[1] : cameras[0],
      ResolutionPreset.medium,
    );
    await _cameraController.initialize();
    _cameraController.startImageStream((image) {
      setState(() {
        _savedImage = image;
        _numberOfFingers = _detectFingerCount(image);
      });
    });
  }

  void _switchCamera() {
    setState(() {
      _isFrontCamera = !_isFrontCamera;
      _cameraController.dispose();
      _initializeCamera();
    });
  }

  int _detectFingerCount(CameraImage image) {
    // Convert the image to a suitable format for finger detection
    // Apply any necessary preprocessing steps

    // Pass the processed image to your finger detection algorithm
    // Replace this with your finger detection algorithm or model

    // Process the image to detect fingers and return the count
    return 0;
  }

  void _startGestureTimer() {
    _gestureTimer = Timer(Duration(seconds: _gestureDisplayDuration), () {
      setState(() {
        _currentGestureIndex++;
        if (_currentGestureIndex >= _gestureAssets.length) {
          _currentGestureIndex = 0;
        }
      });
      _startGestureTimer();
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _gestureTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gesture Detection'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: _savedImage != null
                ? AspectRatio(
                    aspectRatio: _cameraController.value.aspectRatio,
                    child: CameraPreview(_cameraController),
                  )
                : Container(),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(16.0),
                color: Colors.purple.withOpacity(0.8),
                child: Text(
                  'Number of Fingers: $_numberOfFingers',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Roboto',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 16.0,
            right: 16.0,
            child: ElevatedButton(
              onPressed: _switchCamera,
              child: Text('Switch Camera'),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Opacity(
                opacity: 0.8,
                child: Image.asset(
                  _gestureAssets[_currentGestureIndex],
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
