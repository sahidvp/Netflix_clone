import 'dart:async';

import 'package:flutter/material.dart';
import 'package:netfli_project/bottomnavigatinbar/bottomnavigationbar.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(
        const Duration( seconds: 2),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx) =>const BottomNavigationbar())));
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image(
            image: AssetImage(
          "images/netlogo.jpg",
        )),
      ),
    );
  }
}
