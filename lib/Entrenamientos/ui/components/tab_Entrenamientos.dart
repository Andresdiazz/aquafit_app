import 'package:aquafitapp/Entrenamientos/ui/components/contentScrollEntrenamientos.dart';
import 'package:flutter/material.dart';

class TabEntrenamientosWidget extends StatefulWidget {


  final String id;
  final String title;
  final String description;
  final String subtitle;


  TabEntrenamientosWidget({Key key, this.title, this.description, this.subtitle, this.id});

  @override
  _TabEntrenamientosWidgetState createState() => _TabEntrenamientosWidgetState();
}

class _TabEntrenamientosWidgetState extends State<TabEntrenamientosWidget> {



  @override
  Widget build(BuildContext context) {

    var media = MediaQuery.of(context).size;
    return ListView(
      padding: EdgeInsets.only(top: 20, right: 10),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "ENTRENAMIENTOS",
                style: TextStyle(fontSize: 30, color:Color( 0xff3fa0c0 )),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Container(
                  height: 1.5,
                  decoration: BoxDecoration(color: Colors.white),
                ))
          ],
        ),
        SizedBox(height: 10,),
        ContentScrollEntrenamientos(
          id: widget.id,
          imageWidth: 154,
          imageHeight: media.height / 1.5,
          title: widget.title,
          paddingContainer: 0,
          padding: 0,
        )


      ],
    );

  }
}