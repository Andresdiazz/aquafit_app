import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class ContentScrollEntrenamientos extends StatelessWidget {

  final String id;
  final String title;
  final double imageHeight;
  final double imageWidth;
  final double padding;
  final double paddingContainer;

  ContentScrollEntrenamientos({
    this.id,
    this.title,
    this.imageHeight,
    this.imageWidth,
    this.padding,
    this.paddingContainer
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            height: imageHeight,
            child: StreamBuilder(
                stream: Firestore.instance.collection('categorias').snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if (!snapshot.hasData) {  return Text("loading...."); }
                  int length = snapshot.data.documents.length;

                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    scrollDirection: Axis.vertical,
                    itemCount: length,
                    itemBuilder: (_, int index) {
                      //Portada port = portada[index];
                      final DocumentSnapshot doc = snapshot.data.documents[index];
                      return InkWell(
                        onTap: (){
                          print(doc.documentID);
                          /*Navigator.push(context, MaterialPageRoute(
                              builder: (_) => ThirdPage(
                                id: id,
                                title: doc.data['title'],
                                description: doc.data['description'],
                                img:doc.data['img'],
                              )
                          ));*/
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 20.0,
                          ),
                          width: imageWidth,
                          height: imageHeight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black54,
                                offset: Offset(0.0, 4.0),
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Image(
                              image: NetworkImage('${doc.data["img"]}'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  );

                }
            )
        )
      ],
    );
  }
}