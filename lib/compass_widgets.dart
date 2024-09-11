import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';

class CompassWidgets {
  // Widget to build the compass
  static Widget buildCompass() {
    return Expanded(
      child: StreamBuilder<CompassEvent>(
        stream: FlutterCompass.events,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error reading heading: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(
              color: Colors.white,
            ),);
          }

          double? direction = snapshot.data?.heading;

          if (direction == null) {
            return const Center(
              child: Text(
                "Device does not have sensors!",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.redAccent),
              ),
            );
          }

          return Center(
            child: Transform.rotate(
              angle: (direction * (math.pi / 180) * -1),
              child: Container(
                height: 250,
                width: 250,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/compass.jpg'),
                    fit: BoxFit.cover,
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Widget to build direction display
  static Widget buildDirectionDisplay() {
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(
            'Error reading heading: ${snapshot.error}',
            style: const TextStyle(color: Colors.red),
          );
        }

        double? direction = snapshot.data?.heading;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Direction:',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                direction != null ? '${direction.toStringAsFixed(4)}°' : 'N/A',
                style: TextStyle(
                  fontSize: 36,
                  color: Colors.blueGrey[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
