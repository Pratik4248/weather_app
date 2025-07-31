import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import './app.dart';

class City extends StatefulWidget {
  const City({super.key});

  @override
  Citystate createState() => Citystate();
}

class Citystate extends State<City> {
  String city = '';
  final formkey = GlobalKey<FormState>();
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/clouds_video.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.setLooping(true);
        _controller.setVolume(0.0);
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            // Background Video
            _controller.value.isInitialized
                ? FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _controller.value.size.width,
                      height: _controller.value.size.height,
                      child: VideoPlayer(_controller),
                    ),
                  )
                : Container(color: Colors.black),

            // Foreground Form
            SingleChildScrollView(
              padding: const EdgeInsets.only(top: 200.0),
              child: Container(
                margin: const EdgeInsets.all(20.0),
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
                          return null;
                        },
                        decoration: const InputDecoration(
                          icon: Icon(Icons.location_city, color: Colors.black),
                          labelText: 'City ',
                          hintText: 'Enter Your City Name',
                        ),
                        style: const TextStyle(color: Colors.black),
                        onSaved: (value) => city = value!.trim(),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          formkey.currentState!.save();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => App(cityName: city),
                            ),
                          );
                        }
                      },
                      child: const Text('Next'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
