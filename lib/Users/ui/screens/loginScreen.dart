import 'package:aquafitapp/Users/bloc/userBloc.dart';
import 'package:aquafitapp/Users/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

import '../../../Entrenamientos/ui/screens/homeScreen.dart';
import 'loginForm.dart';
import 'registerScreen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserBloc userBloc;

  bool _loading = false;

  String _errorMessage = "";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>( );

  String email = "";
  String password = "";

  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of( context );
    return _handleCurrentSession( );
  }

  Widget _handleCurrentSession() {
    return StreamBuilder(
      stream: userBloc.authStatus ,
      builder: (BuildContext context , AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return IntroPage( );
        } else {
          return HomeScreen( );
        }
      } ,
    );
  }

  Widget IntroPage() {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage( "images/img/03.gif" ) ,
                    fit: BoxFit.cover ) ) ,
          ) ,
          Container(
            color: Colors.black.withOpacity( 0.7 ) ,
          ) ,
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center ,
              children: [
                Image.asset(
                  "images/logos/LOGO BLANCO.png" ,
                  width: 217 ,
                  height: 122 ,
                ) ,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center ,
                  children: [
                    Text(
                      "Tus entrenamientos están esperando" ,
                      style: TextStyle( color: Colors.white , fontSize: 20 ) ,
                    ) ,
                    SizedBox(
                      width: 10 ,
                    ) ,
                    Icon(
                      FontAwesomeIcons.swimmer ,
                      color: Colors.amber ,
                    )
                  ] ,
                ) ,
              ] ,
            ) ,
          ) ,
          Align(
            alignment: Alignment.bottomLeft ,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 20 , horizontal: 5 ) ,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround ,
                children: [
                  RaisedButton(
                    onPressed: () =>
                    {
                      Navigator.push(
                          context ,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  RegisterScreen( ) ) )
                    } ,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center ,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20 , horizontal: 30 ) ,
                          child: Text(
                            "Crear Cuenta" ,
                            style: TextStyle(
                                color: Color( 0xff3fa0c0 ) ,
                                fontSize: 15 ,
                                fontWeight: FontWeight.bold ) ,
                          ) ,
                        ) ,
                        if (_loading)
                          Container(
                            height: 20 ,
                            width: 20 ,
                            margin: const EdgeInsets.only( left: 20 ) ,
                            child: CircularProgressIndicator( ) ,
                          )
                      ] ,
                    ) ,
                    color: Colors.white ,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular( 50 ) ) ,
                  ) ,
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context ,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  LoginForm( ) ) );
                    } ,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center ,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20 , horizontal: 30 ) ,
                          child: Text(
                            "Iniciar Sesión" ,
                            style: TextStyle(
                                color: Colors.white ,
                                fontSize: 15 ,
                                fontWeight: FontWeight.bold ) ,
                          ) ,
                        ) ,
                        if (_loading)
                          Container(
                            height: 20 ,
                            width: 20 ,
                            margin: const EdgeInsets.only( left: 20 ) ,
                            child: CircularProgressIndicator( ) ,
                          )
                      ] ,
                    ) ,
                    color: Colors.transparent ,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular( 50 ) ,
                        side: BorderSide( color: Colors.white ) ) ,
                  ) ,
                ] ,
              ) ,
            ) ,
          )
        ] ,
      ) ,
    );
  }
}

class HomePage extends StatelessWidget {
  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            userBloc.signOut();
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
          },
          child: Text("Cerrar Sesión"),
        ),
      ),
    );
  }
}
