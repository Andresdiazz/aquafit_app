import 'package:animated_splash/animated_splash.dart';
import 'package:flutter/material.dart';

import 'src/myapp.dart';

void main() {

  Function duringSplash = () {
    print('Something background process');
    int a = 123 + 23;
    print(a);

    if (a > 100)
      return 1;
    else
      return 2;
  };

  Map<int, Widget> op = {
    1: MyApp()

  };

  runApp(MaterialApp(
    home: AnimatedSplash(
      imagePath: 'images/logos/LOGO AQUA FIT.png',
      home: MyApp(),
      customFunction: duringSplash,
      duration: 2500,
      type: AnimatedSplashType.BackgroundProcess,
      outputAndHome: op,
    ),
  ));


}

