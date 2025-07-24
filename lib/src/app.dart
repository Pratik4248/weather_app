import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' show get;
import './weather_forecast.dart';

class App extends StatefulWidget {
  final String cityName;

  const App({super.key, required this.cityName});

  @override
  Appstate createState() => Appstate();
}

class Appstate extends State<App> {

   Weather? weather; // To store the fetched data
  bool isLoading = true;

   @override
  void initState() {
    super.initState();
    fetchdata(); // Call fetch on load
  }

  void fetchdata() async {
    final response = await get(
      Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=${widget.cityName}&appid=19383e15f3e9174045f54ec2bb7b795d"));
       if (response.statusCode == 200) {
      final data = Weather.fromjson(json.decode(response.body));
      setState(() {
        weather = data;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      // You can also show an error message
      print("Failed to load weather data");
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 186, 234, 243),
        body: weather == null
          ? const Center(child: CircularProgressIndicator())
          : design(),
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

                //Text 1
                Text(
                  "Today's Weather - ${widget.cityName}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 20), // Gap between 2 texts

                //Text 2
                 Text(
                  "${weather?.cityname}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                 ),
                SizedBox(height: 10), // Gap between 2 texts
                 Text(
                  'Condition: ${weather?.description}',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  'Temperature: ${weather?.temperature} °C',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  'Humidity: ${weather?.humidity}%',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  'Wind Speed: ${weather?.windspeed} m/s',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
