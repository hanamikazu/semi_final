import 'package:flutter/material.dart';
import 'package:semi_final/home.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.teal
    ),
    home: const Home(),
  ));
}

