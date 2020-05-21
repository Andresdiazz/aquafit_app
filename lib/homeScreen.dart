import 'package:aquafitapp/homeFoot.dart';
import 'package:flutter/material.dart';

import 'homeHeader.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HomeHeader(),
          HomeFoot(),
        ],
      ),
    );
  }
}
