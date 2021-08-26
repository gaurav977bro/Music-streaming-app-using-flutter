import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'LoginScreen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: Center(child: Text("hell")));
  }
}
