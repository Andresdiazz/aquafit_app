import 'package:aquafitapp/Users/bloc/userBloc.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

import '../Users/ui/screens/loginScreen.dart';
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: "Gasalt",
          primaryColor: Colors.white,
          accentColor: Colors.white,
          brightness: Brightness.light
        ),
          title: "Aqua Fit Salud y Deporte",

        home: LoginPage(),
      ),
      bloc: UserBloc(),
    );
  }
}
