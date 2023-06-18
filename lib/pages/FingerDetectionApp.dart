import 'package:flutter/material.dart';
import 'FingerDetectionScreen.dart';

class FingerDetectionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finger Detection',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: FingerDetectionScreen(),
    );
  }
}
