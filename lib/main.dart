import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shots_roulette/screens/overview/overview.dart';
import 'package:shots_roulette/themeData.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MaterialApp(
      title: 'Shots Roulette',
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: Overview(),
    );
  }
}
