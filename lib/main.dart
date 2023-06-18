import 'package:flutter/material.dart';
import '/pages/WelcomePage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finger Detection',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: WelcomePage(),
    );
  }
}
