import 'package:aquafitapp/Entrenamientos/ui/components/tab_Entrenamientos.dart';
import 'package:flutter/material.dart';


class SecondPage extends StatefulWidget {

  final String id;

  final String title;
  final String img;
  final String description;
  final String subtitle;



  SecondPage({this.title,this.img,this.description,this.subtitle, this.id});

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: DefaultTabController(
        length: 1,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
            return [
              SliverAppBar(
                title: Text(widget.title.toUpperCase(), style: TextStyle(color: Colors.white),),
                expandedHeight: 230,
                flexibleSpace: Hero(
                  tag: widget.img,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(widget.img),
                            fit: BoxFit.cover
                        )
                    ),
                    child: Container(
                      color: Colors.black.withOpacity(.5),
                    ),
                  ),
                ),
                pinned: true,
                bottom: TabBar(
                    labelColor: Color( 0xff3fa0c0 ),
                    indicatorColor: Color( 0xff3fa0c0 ),
                    indicatorWeight: 6,
                    tabs: <Widget>[
                      Tab(
                        child: Text("", style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),),
                      ),

                    ]),
              )
            ];
          },
          body: TabBarView(children: <Widget>[
            Container(
              //color: Colors.white,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50)
                )
              ),
              child: TabEntrenamientosWidget(
                id: widget.id,
                title: widget.title,
                description: widget.description,
                subtitle: widget.subtitle,
              ),
            ),

          ]),

        ),
      ),
    );
  }
}