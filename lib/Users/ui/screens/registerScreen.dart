import 'package:aquafitapp/Users/bloc/userBloc.dart';
import 'package:aquafitapp/Users/model/user.dart';
import 'package:aquafitapp/Users/ui/screens/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

import 'registerScreen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  UserBloc userBloc;

  bool _loading = false;

  String _errorMessage = "";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  String name = "";
  int age;

  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(context);
    return _handleCurrentSession();
  }

  Widget _handleCurrentSession() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      "images/logos/LOGO AQUA FIT.png",
                      width: 217 ,
                      height: 122 ,
                    ),
                    SizedBox(height: 10,),
                    Text(
                      "BIENVENIDO AL CLUB \n AQUA FIT",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              height: 45,
                              child: Theme(
                                data: Theme.of(context).copyWith(primaryColor: Color( 0xff3fa0c0 )),
                                child: TextFormField(
                                  style: TextStyle( fontSize: 18),
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      hintText: "Email",
                                      hintStyle: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5)
                                      )
                                  ),
                                  onSaved: (value) {
                                    email = value;
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Este campo es obligatorio';
                                    }
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 45,
                              child: Theme(
                                data: Theme.of(context).copyWith(primaryColor: Color( 0xff3fa0c0 )),
                                child: TextFormField(
                                  style: TextStyle( fontSize: 18),
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    hintStyle: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                    suffixIcon: IconButton(
                                        icon: Icon(showPassword
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                        onPressed: () {
                                          setState(() {
                                            showPassword = !showPassword;
                                          });
                                        }),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                  obscureText: !showPassword,
                                  onSaved: (value) {
                                    password = value;
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Este campo es obligatorio';
                                    }
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 45,
                              child: Theme(
                                data: Theme.of(context).copyWith(primaryColor: Color( 0xff3fa0c0 )),
                                child: TextFormField(
                                  style: TextStyle( fontSize: 18),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText: "Nombre Completo",
                                    hintStyle: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),

                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                  ),

                                  onSaved: (value) {
                                    name = value;
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Este campo es obligatorio';
                                    }
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 45,
                              child: Theme(
                                data: Theme.of(context).copyWith(primaryColor: Color( 0xff3fa0c0 )),
                                child: TextFormField(
                                  style: TextStyle( fontSize: 18),
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: "Edad",
                                    hintStyle: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),

                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                  ),

                                  onSaved: (int) {
                                    age;
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Este campo es obligatorio';
                                    }
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            RaisedButton(
                              onPressed: () => _createAccount(context),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "CREAR CUENTA",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 22),
                                  ),
                                  if (_loading)
                                    Container(
                                      height: 20,
                                      width: 20,
                                      margin: const EdgeInsets.only(left: 20),
                                      child: CircularProgressIndicator(),
                                    )
                                ],
                              ),
                              color: Color( 0xff3fa0c0 ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            RaisedButton(
                              onPressed: () => _loginGoogle(context),
                              child: Icon(
                                FontAwesomeIcons.google,
                                color: Colors.white,
                              ),
                              color: Color( 0xff3fa0c0 ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            if (_errorMessage.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  _errorMessage,
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            SizedBox(
                              height: 30,
                            ),
                            FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              RegisterScreen()));
                                },
                                child: Text(
                                  "¿Ya tienes una cuenta?",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontStyle: FontStyle.italic,
                                      decoration: TextDecoration.underline),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(icon: Icon(Icons.close), onPressed: (){

              Navigator.pop(context);
            }),
          ],
        ),
      ),
    );
  }

  _createAccount(BuildContext context) async {
    if (!_loading) {
      if (_formKey.currentState.validate( )) {
        _formKey.currentState.save( );
        setState( () {
          _loading = true;
          _errorMessage = "";
        } );
        try {
          var user = await userBloc.createAccountEmail(email , password ).then( (
              FirebaseUser user) {
            userBloc.updateUserData( User(
                uid: user.uid ,
                email: user.email ,
                name: user.displayName
            ) );
          } );
          Navigator.of(context).pop(context);
          Navigator.of(context).pushReplacementNamed('/imc');
          return user != null;
        } catch (e) {
          setState( () {
            _loading = false;
            _errorMessage = "Email o contraseña incorrecta";
          } );
          return e.message;
        }
      }
    }
  }

  _loginGoogle(BuildContext context) async {
    if (!_loading) {
      setState(() {
        _loading = true;
        _errorMessage = "";
      });
      try {
        var user = await userBloc.signInWithGoogle().then((FirebaseUser user) {
          userBloc.updateUserData(
              User(uid: user.uid, email: user.email, name: user.displayName));
        });
        Navigator.of(context).pop(context);
        Navigator.of(context).pushReplacementNamed('/imc');
        return user != null;
      } catch (e) {
        setState(() {
          _loading = false;
          _errorMessage = "Email o contraseña incorrecta";
        });
        return e.message;
      }
    }
  }

}