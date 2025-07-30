import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' show get;
import './weather_forecast.dart';
import 'package:intl/intl.dart';

class App extends StatefulWidget {
  final String cityName;

  const App({super.key, required this.cityName});

  @override
  Appstate createState() => Appstate();
}

class Appstate extends State<App> {

   Weather? weather; // To store the fetched data

  bool isLoading = true;  //This lets you show a loading UI while data is being fetched.

   @override
   //	initState() --> Runs 1st  when the widget/screen is created
  void initState() {

    /*In Flutter, when you create a StatefulWidget, you extend a class called State.
That State class already has a built-in initState() method that does some important internal setup (like preparing the widget to be inserted into the widget tree).
When you override initState() in your class (write your own version), Flutter won’t run the parent’s method unless you manually call it.*/

    super.initState();
    fetchdata(); // Call fetch on load
  }

  void fetchdata() async {
    final response = await get(
      Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=${widget.cityName}&appid=19383e15f3e9174045f54ec2bb7b795d"));

      //response.statuscode == 200 means data is successfully fetched....any number other than 200 means failed to fetch data 
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
  String getBackgroundImage(String weatherDescription) {
  switch (weatherDescription.toLowerCase()) {
    case 'drizzle':
      return 'assets/drizzle.png';
    case 'clouds':
      return 'assets/cloudy.png';
    case 'rain':
      return 'assets/rain.png';
    case 'snow':
      return 'assets/snow.png';
    case 'thunderstorm':
      return 'assets/thunderstorm.png';
    case 'mist':
    case 'haze':
    case 'fog':
      return 'assets/mist.png';
    default:
      return 'assets/cloudy.png'; // fallback
  }
}

 // Convert UNIX timestamp to 24-hour format time string
  String formatTime(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    final formatter = DateFormat('HH:mm'); // 24-hour format
    return formatter.format(date);
  }

  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 201, 234, 234),
    

/* weather == null --> You're checking if the variable weather has no data yet (probably because the API hasn’t returned anything yet).
   This means the app is still loading weather data.
   
   ? const Center(child: CircularProgressIndicator()) --> If weather == null is true, show this:
  A spinner/loading icon in the center.
  const is added for performance (because it's a static widget).
  This means "we are still fetching the data."

  : design() --> If weather != null (i.e., data is fetched successfully), show the result of the design() function.
    */
        body:  Stack(
    children: [
      // Weather-based background image
      if (weather != null)
        Positioned.fill(
          child: Image.asset(
            getBackgroundImage(weather!.description),
            fit: BoxFit.cover,
          ),
        ),

      // Optional dark overlay for readability
      Positioned.fill(
        child: Container(
          color: const Color.fromARGB(77, 0, 0, 0),
        ),
      ),

      // Foreground content
      weather == null
          ? const Center(child: CircularProgressIndicator())
          : SizedBox.expand(child: design()),
    ],
  ),
      ),
    );
  }

  Widget design() {
    return SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 40),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            width: 400,
            height: 250,
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                // Text(
                //   "Current Weather",
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontStyle: FontStyle.italic,
                //     fontSize: 25,
                //     fontWeight: FontWeight.bold,
                //   ),
                //   textAlign: TextAlign.center,
                // ),
                SizedBox(height: 20),
                Text(
                  "📍 ${weather?.cityname}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  '  ${weather?.temperature}°C',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 80,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              
              ],
            ),
          ),
        ),
                SizedBox(height: 65),

              Padding(
  padding: EdgeInsets.symmetric(horizontal: 20.0),
  child: Container(
            height: 320,
    width: double.infinity,
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      // color: Colors.black,
       gradient: LinearGradient(
    colors: [const Color.fromARGB(93, 218, 228, 228), const Color.fromARGB(93, 218, 228, 228)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
      borderRadius: BorderRadius.circular(35),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        Text(
          "☁️  Condition - ${weather?.description}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 15),
        Text(
          "💧  Humidity - ${weather?.humidity}%",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 15),
        Text(
          "༄  Windspeed - ${weather?.windspeed} m/s",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 15),
        Text(
          "☀️  Sunrise - ${formatTime(weather!.sunrise)} ",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 15),
        Text(
          "🌇  Sunset - ${formatTime(weather!.sunset)}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  ),
),

      ],
    ),
  );
    
    }

}
