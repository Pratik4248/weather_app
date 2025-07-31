import 'package:flutter/material.dart';
import './app.dart';

class City extends StatefulWidget {
  const City({super.key});
   
  @override
  Citystate createState()=>Citystate();

}

class Citystate extends State<City> {
    String city = '';
  final formkey = GlobalKey<FormState>();

         @override
   Widget build (BuildContext context){
         return MaterialApp(
           debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: const Color.fromARGB(255, 206, 242, 243),
            body: Container(
              padding: EdgeInsets.only(top: 200.0),
              margin: EdgeInsets.all(20.0),

              child: Column(

              children: [
              Form(
                key: formkey,
                child: TextFormField(
            textCapitalization: TextCapitalization.words,
             validator: (value) {
           if (value == null || value.isEmpty) {
                 return 'Enter a city name';
                }
                return null; // <-- This is needed to indicate no error
              },

    decoration: InputDecoration(
    icon: Icon(Icons.location_city),
    labelText: 'City ',
    hintText: 'Enter Your City Name', 
  ),
  onSaved: (value) =>  city = value!.trim(),
    ),
     ),

     SizedBox(height: 30),
    ElevatedButton(
      onPressed: (){
     if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      Navigator.push(context, MaterialPageRoute(builder: (context)=>App(cityName: city)));
        }
      },
     child: Text('Next'),
     ),
              ],
             
              ),
            ),
          ),
         );
   }
  }