// @dart=2.9

import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import 'package:mymusic/screens/HomeScreen.dart';
import 'package:mymusic/screens/LoginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyMusic());
}

class MyMusic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.green),
        initialRoute: "/login",
        debugShowCheckedModeBanner: false,
        routes: {
          "/login": (context) => Login(),
          "/home": (context) => Home(),
        });
  }
}
