import 'package:aquafitapp/Users/bloc/userBloc.dart';
import 'package:aquafitapp/Users/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

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
    return _handleCurrentSession();
  }
    Widget _handleCurrentSession(){
      return StreamBuilder(
        stream: userBloc.authStatus,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(!snapshot.hasData){
            return LoginForm();
          }else{
            return HomePage();
          }
        },
      );
    }


    Widget LoginForm(){
      return Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/img/01.jpeg"), fit: BoxFit.cover)
              ),
            ),
            Container(
              color: Colors.black.withOpacity(0.5),
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("images/logos/LOGO AQUA FIT.png", width: 217, height: 122,),
                    Text("Inicia Sesión", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold, letterSpacing: 1.5),),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Tus entrenamientos están esperando", style: TextStyle(color: Colors.white, fontSize: 20),),
                        SizedBox(width: 10,),
                        Icon(FontAwesomeIcons.swimmer, color: Colors.amber,)
                      ],
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              style: TextStyle(color: Colors.white, fontSize: 18),
                              decoration: InputDecoration(
                                labelText: "Email",
                                labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white)
                                ),
                              ),
                              onSaved: (value) {
                                email = value;
                              } ,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Este campo es obligatorio';
                                }
                              } ,
                            ),
                            SizedBox(height: 5,),
                            TextFormField(
                              style: TextStyle(color: Colors.white, fontSize: 18),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                labelText: "Password",
                                labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),
                                suffixIcon: IconButton(icon: Icon(showPassword?Icons.visibility:Icons.visibility_off), onPressed: (){
                                  setState(() {
                                    showPassword = !showPassword;
                                  });
                                }),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white)
                                ),
                              ),
                              obscureText: !showPassword,
                              onSaved: (value) {
                                password = value;
                              } ,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Este campo es obligatorio';
                                }
                              },
                            ),
                            SizedBox(height: 20,),
                            RaisedButton(
                              onPressed: () => _login(context),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("INICIAR SESIÓN", style: TextStyle(color: Colors.white, fontSize: 22),),
                                  if (_loading)
                                    Container(height: 20, width: 20,
                                      margin: const EdgeInsets.only(left: 20),
                                      child: CircularProgressIndicator(),)
                                ],
                              ),
                              color: Color(0xff3fa0c0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)
                              ),
                            ),
                            RaisedButton(
                              onPressed: () => _loginGoogle(context),
                              child: Icon(FontAwesomeIcons.google, color: Colors.white,),
                              color: Color(0xff3fa0c0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)
                              ),
                            ),
                            if (_errorMessage.isNotEmpty)
                              Padding(padding: const EdgeInsets.all(8),
                                child: Text(_errorMessage, style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold
                                ), textAlign: TextAlign.center,
                                ),),
                            SizedBox(height: 30,),
                            FlatButton(onPressed: (){
                              Navigator.push( context , MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      RegisterScreen( ) ) );
                            },
                                child: Text("¿No tienes una cuenta?", style: TextStyle(color: Colors.white, fontSize: 15, fontStyle: FontStyle.italic, decoration: TextDecoration.underline),)
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }


  _login(BuildContext context) async {
    if (!_loading) {
      if (_formKey.currentState.validate( )) {
        _formKey.currentState.save( );
        setState( () {
          _loading = true;
          _errorMessage = "";
        } );
        try {
          var user = await userBloc.signInEmail(email, password).then((FirebaseUser user){
            userBloc.updateUserData(User(
                uid: user.uid,
                email: user.email,
                name: user.displayName
            ));
          });
          //Navigator.of(context).pop(context);
          //Navigator.of(context).pushReplacementNamed('/home');
          return user != null;
        }catch (e){
          setState(() {
            _loading = false;
            _errorMessage = "Email o contraseña incorrecta";
          });
          return e.message;
        }
      }
    }
  }

  _loginGoogle(BuildContext context) async {
    if (!_loading) {
      setState( () {
        _loading = true;
        _errorMessage = "";
      } );
      try {
        var user = await userBloc.signInWithGoogle().then((FirebaseUser user){
          userBloc.updateUserData(User(
              uid: user.uid,
              email: user.email,
              name: user.displayName
          ));
        });
        return user != null;
      }catch (e){
        setState(() {
          _loading = false;
          _errorMessage = "Email o contraseña incorrecta";
        });
        return e.message;
      }

    }
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
        child: RaisedButton(onPressed: (){
          userBloc.signOut();
        },
        child: Text("Cerrar Sesión"),),
      ),
    );
  }
}
