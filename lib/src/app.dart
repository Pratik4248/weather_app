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

  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 186, 234, 243),

/* weather == null --> You're checking if the variable weather has no data yet (probably because the API hasn’t returned anything yet).
   This means the app is still loading weather data.
   
   ? const Center(child: CircularProgressIndicator()) --> If weather == null is true, show this:
  A spinner/loading icon in the center.
  const is added for performance (because it's a static widget).
  This means "we are still fetching the data."

  : design() --> If weather != null (i.e., data is fetched successfully), show the result of the design() function.
    */
        body: weather == null
          ? const Center(child: CircularProgressIndicator())
          :  design(),
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
              image: DecorationImage(
                image: AssetImage(getBackgroundImage(weather?.description?? 'Clouds')),
                fit: BoxFit.cover,
              ),
              color: Colors.black,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Text(
                  "Weather",
                  style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  "${weather?.cityname}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  ' ${weather?.temperature}°C',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 70,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              
              ],
            ),
          ),
        ),
                SizedBox(height: 50),

                //Conditon box
                Padding(padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  width: 400,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.black,
              borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                       Text(
                  "Condition - ${weather?.description}",
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
                SizedBox(height: 20),

                //Humidity box
                Padding(padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  width: 400,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.black,
              borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                       Text(
                  "Humidity - ${weather?.humidity}%",
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


                SizedBox(height: 20),

                //Windspeed Box
                Padding(padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  width: 400,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.black,
              borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                       Text(
                  "Windspeed - ${weather?.windspeed}m/s",
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


                SizedBox(height: 20),

                //Sunrise box
                Padding(padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  width: 400,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.black,
              borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                       Text(
                  "Sunrise - ${weather?.sunrise}",
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


                SizedBox(height: 20),

                //Sunset box

                Padding(padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  width: 400,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.black,
              borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                       Text(
                  "Sunset - ${weather?.sunset}",
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
