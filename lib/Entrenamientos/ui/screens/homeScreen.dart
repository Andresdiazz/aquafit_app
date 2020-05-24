import 'package:aquafitapp/Entrenamientos/ui/components/homeFoot.dart';
import 'package:flutter/material.dart';

import '../components/homeHeader.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeHeader(),
            HomeFoot(
              title: "hola",
              imageHeight: 350,
              imageWidth: 216,
              padding: 0,
              paddingContainer: 10,
            ),
          ],
        ),
      ),
    );
  }
}
