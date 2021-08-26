// @dart=2.9

import 'package:firebase_auth/firebase_auth.dart';
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
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class KeepLogged extends StatefulWidget {
  @override
  _KeepLoggedState createState() => _KeepLoggedState();
}

class _KeepLoggedState extends State<KeepLogged> {
  FirebaseAuth _auth;
  User _user;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Scaffold(body: Center(child: CircularProgressIndicator()))
        : _user == null
            ? Login()
            : Home();
  }
}
