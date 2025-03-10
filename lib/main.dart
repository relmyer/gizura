import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  runApp(Gizura());
}

class Gizura extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      home: MagicBallScreen(),
    );
  }
}

class MagicBallScreen extends StatefulWidget {
  @override
  _MagicBallScreenState createState() => _MagicBallScreenState();
}

class _MagicBallScreenState extends State<MagicBallScreen> {
  int imageIndex = 1;
  bool isShaking = false;
  double opacity = 1.0;

  @override
  void initState() {
    super.initState();

    imageIndex = Random().nextInt(23) + 1;

    accelerometerEvents.listen((AccelerometerEvent event) {
      double shakeThreshold = 15.0;
      double acceleration = (event.x * event.x) + (event.y * event.y) + (event.z * event.z);
      if (acceleration > shakeThreshold) {
        onShakeDetected();
      }
    });
  }

  void getRandomImage() {
    setState(() {
      opacity = 0.0;
    });

    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        imageIndex = Random().nextInt(23) + 1;
        opacity = 1.0;
      });
    });
  }

  void onShakeDetected() {
    if (!isShaking) {
      setState(() {
        isShaking = true;
      });

      Future.delayed(const Duration(milliseconds: 500), () {
        getRandomImage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Sor Bakalım",
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: getRandomImage,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedOpacity(
                duration: Duration(milliseconds: 500),
                opacity: opacity,
                child: Image.asset(
                  'images/$imageIndex.png',
                  width: 300,
                  height: 300,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Telefonu salla veya ekrana dokun!",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
