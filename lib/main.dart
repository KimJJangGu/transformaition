import 'package:flutter/material.dart';
import 'package:transfomation/length.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '단위 변환기',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LengthConverter(),
    );
  }
}