import 'package:flutter/material.dart';

class HomeFoot extends StatefulWidget {
  @override
  _HomeFootState createState() => _HomeFootState();
}

class _HomeFootState extends State<HomeFoot> {
  @override
  Widget build(BuildContext context) {

    var media = MediaQuery.of(context).size;
    PageController _pageController;

    @override
    void initState() {
      super.initState();
      _pageController = PageController(initialPage: 1, viewportFraction: 0.8);
    }

    final Cards = AnimatedBuilder(
        animation: _pageController,
        builder: (BuildContext context, Widget widget){
          double value = 1;
          if (_pageController.position.haveDimensions){
            value = _pageController.page;
            value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
          }
        });

    

    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: [
          Text("CATEGORIAS", style: TextStyle(fontSize: 30),)
        ],
      ),
    );
  }
}
