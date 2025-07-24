
import 'package:flutter/material.dart';
import 'package:weather_app/splash_screen/splash_screen.dart';
// import '../src/city.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false, // optional
      home: SplashScreen(), // this is your splash screen
    ),
  );
}