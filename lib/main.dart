import 'package:flutter/material.dart';
import 'package:insekul_app/Custom/CustomFont.dart';
import 'package:insekul_app/Pages/LoginPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Insekul App',
      theme: ThemeData(
        textTheme: newTextTheme,
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
