import 'package:flutter/material.dart';
import 'compass_widgets.dart'; // Import the CompassWidgets class

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Compass App'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 4.0,
      ),
      body: Column(
        children:[
          CompassWidgets.buildCompass(),
          CompassWidgets.buildDirectionDisplay(),
        ],
      ),
    );
  }
}
