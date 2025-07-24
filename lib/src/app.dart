import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' show get;
import './city.dart';
import './weather_forecast.dart';

class App extends StatefulWidget {
  final String cityName;

  const App({super.key, required this.cityName});

  @override
  Appstate createState() => Appstate();
}

class Appstate extends State<App> {
  void fetchdata() async {
    final response = await get(
      Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=${widget.cityName}&appid=19383e15f3e9174045f54ec2bb7b795d"));
      final data = Weather.fromjson(json.decode(response.body));
      setState(() {
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 186, 234, 243),
        body: design(),
      ),
    );
  }

  Widget design() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start, // Align to top
      children: [
        SizedBox(height: 40), // Add space from top (status bar)
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            width: 400,
            height: 250,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20), // Padding from top
                Text(
                  "Today's Weather - ${widget.cityName}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                // You can add more widgets below if needed
              ],
            ),
          ),
        ),
      ],
    );
  }
}
