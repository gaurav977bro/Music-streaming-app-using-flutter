import "package:flutter/material.dart";
import 'package:mymusic/screens/HomeScreen.dart';
import 'package:mymusic/screens/LoginScreen.dart';

void main() {
  runApp(MyMusic());
}

class MyMusic extends StatelessWidget {
  const MyMusic({ Key? key }) : super(key: key);

  @override///
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:ThemeData(primarySwatch:Colors.green),
      initialRoute:"/login",
      routes:{
        "/login":(context)=>Login(),
        "/home":(context)=>Home(),
      }
      
      
    );
  }
}
