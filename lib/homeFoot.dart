import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeFoot extends StatefulWidget {

  final String title;
  final double imageHeight;
  final double imageWidth;
  final double padding;
  final double paddingContainer;

  const HomeFoot({Key key, this.title, this.imageHeight, this.imageWidth, this.padding, this.paddingContainer}) : super(key: key);

  @override
  _HomeFootState createState() => _HomeFootState();
}

class _HomeFootState extends State<HomeFoot> {
  @override
  Widget build(BuildContext context) {

    final Card = Container(
        height: widget.imageHeight,
        child: StreamBuilder(
          stream: Firestore.instance.collection('categorias').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if (!snapshot.hasData) {  return Text("loading...."); }
            int length = snapshot.data.documents.length;

            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              scrollDirection: Axis.horizontal,
              itemCount: length,
              itemBuilder: (_, int index) {
                //Portada port = portada[index];
                final DocumentSnapshot doc = snapshot.data.documents[index];
                return InkWell(
                  onTap: (){
                    print(doc.documentID);
                    /*Navigator.push(context, MaterialPageRoute(
                        builder: (_) => SecondPage(
                          id: doc.documentID,
                          title: doc.data['title'],
                          subtitle: doc.data['subtitle'],
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
                    width: widget.imageWidth,
                    height: widget.imageHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54,
                          offset: Offset(0.0, 4.0),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(25.0),
                          child: Image(
                            image: NetworkImage( '${doc.data["img"]}'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                          child: Text(doc.data['title'], style: TextStyle(fontSize: 22, color: Colors.white),),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                            child: Row(
                              children: [
                                Icon(FontAwesomeIcons.dumbbell, color: Colors.white,),
                                SizedBox(width: 15,),
                                Text(doc.data['entrenamientos'], style: TextStyle(fontSize: 15, color: Colors.white),),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );

          },
        )

    );
    

    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("CATEGORIAS", style: TextStyle(fontSize: 30),),
              )),
          Card
        ],
      ),
    );
  }
}
