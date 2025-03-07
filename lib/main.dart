import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'Sigmar',
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Sor bakalım",
            style: TextStyle(
              fontFamily: 'Sigmar',
              fontSize: 24,
            ),
          ),
          backgroundColor: Colors.white,
        ),
      ),
    ),
  );
}