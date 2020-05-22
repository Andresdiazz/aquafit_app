import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

import 'Users/bloc/userBloc.dart';
import 'Users/ui/screens/loginScreen.dart';

class HomeHeader extends StatefulWidget {
  @override
  _HomeHeaderState createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {

  UserBloc userBloc;


  @override
  Widget build(BuildContext context) {


    var media = MediaQuery.of(context).size;
    userBloc = BlocProvider.of(context);

    return Stack(
        children: [
          Container(
            height: media.height / 2.4,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(30),
                    bottomRight: const Radius.circular(30)
                ),
              image: DecorationImage(image: NetworkImage("https://images.pexels.com/photos/3875505/pexels-photo-3875505.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
              fit: BoxFit.cover),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.41),
                  offset: Offset(0, 7),
                  blurRadius: 6
                )
              ]
            ),
          ),
          Container(
              height: media.height / 2.4,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: const Radius.circular(30),
                bottomRight: const Radius.circular(30)
              ),
              color: Colors.black.withOpacity(0.7),
            ),
            child: Align(
              alignment: Alignment.bottomRight,
              child: IconButton(icon: Icon(FontAwesomeIcons.signOutAlt, color: Colors.white,), onPressed: (){
                userBloc.signOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
              }),
            ),
          ),
          Container(
            height: media.height / 2.6,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("¡Hi, Andres!", style: TextStyle(color: Colors.white, fontSize: 30,fontWeight: FontWeight.w400),),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        maxRadius: 27,
                        backgroundImage: NetworkImage("https://images.pexels.com/photos/4255485/pexels-photo-4255485.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940")
                        //child: Image.network("https://images.pexels.com/photos/4255485/pexels-photo-4255485.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(

                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            maxRadius: 25,
                            child: Center(
                              child: Icon(FontAwesomeIcons.rulerVertical, color: Colors.amberAccent,),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Text("1.76", style: TextStyle(color: Colors.white, fontSize: 22),)
                        ],
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            maxRadius: 25,
                            child: Center(
                              child: Icon(FontAwesomeIcons.weight, color: Colors.redAccent,),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Text("70", style: TextStyle(color: Colors.white, fontSize: 22),)
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey,
                              maxRadius: 25,
                              child: Center(
                                child: Text("IMC", style: TextStyle(color: Colors.purpleAccent, fontWeight: FontWeight.w600),)
                              ),
                            ),
                            SizedBox(width: 10,),
                            Text("2.67", style: TextStyle(color: Colors.white, fontSize: 22),)
                          ],
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey,
                              maxRadius: 25,
                              child: Center(
                                child: Icon(FontAwesomeIcons.solidSmileBeam, color: Colors.blueAccent,),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Text("25", style: TextStyle(color: Colors.white, fontSize: 22),)
                          ],
                        )
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),

        ],
      );

  }
}
