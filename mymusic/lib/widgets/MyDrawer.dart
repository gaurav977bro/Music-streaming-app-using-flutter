import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mymusic/screens/HomeScreen.dart';
import 'package:mymusic/screens/LoginScreen.dart';
import 'package:mymusic/widgets/SongWidget.dart';

class My_Drawer extends StatefulWidget {
  @override
  _My_DrawerState createState() => _My_DrawerState();
}

class _My_DrawerState extends State<My_Drawer> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  var userName = TextEditingController();
  var userEmail;

  final _key = GlobalKey<FormState>();

  changeInfo(context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.blue, Colors.black],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 20),
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 30)),
                    form(),
                    SizedBox(
                      height: 30,
                    ),
                    textField(),
                    SizedBox(
                      height: 30,
                    ),
                    textField2(),
                    SizedBox(
                      height: 30,
                    ),
                    saveButton(),
                  ],
                ),
              ),
            )));
  }

  form() {
    return Container(
      child: Text(
        "Profile Setting",
        style: TextStyle(color: Colors.white, fontSize: 30),
      ),
    );
  }

  textField() {
    return TextFormField(
      validator: RequiredValidator(errorText: "Required*"),
      controller: userName,
      decoration: InputDecoration(
        hintText: "Name",
        labelText: "enter your name",
        hintStyle: TextStyle(color: Colors.white),
        labelStyle: TextStyle(color: Colors.white),
      ),
    );
  }

  textField2() {
    return TextFormField(
      validator: RequiredValidator(errorText: "Required*"),
      controller: userName,
      decoration: InputDecoration(
        hintText: "Email address",
        labelText: "enter your email",
        hintStyle: TextStyle(color: Colors.white),
        labelStyle: TextStyle(color: Colors.white),
      ),
    );
  }

  saveButton() {
    return ElevatedButton(
        child: Text("Save"),
        onPressed: () {
          setState(() {
            if (_key.currentState!.validate()) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()));
            }
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.blue, Colors.black],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: DrawerHeader(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.black, Colors.red],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                      ),
                      child: UserAccountsDrawerHeader(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        arrowColor: Colors.white,
                        currentAccountPicture: CircleAvatar(
                          backgroundImage:
                              NetworkImage(SongsWidget.songList[0].image),
                        ),
                        accountEmail: Text("User Email"),
                        accountName: Text(userName.text.toString()),
                        currentAccountPictureSize: Size(40, 40),
                      )),
                ),
                SizedBox(height: 30),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => changeInfo(context)));
                  },
                  leading: Icon(Icons.settings, color: Colors.white),
                  title:
                      Text("Settings", style: TextStyle(color: Colors.white)),
                  subtitle: Text("acocunt settings",
                      style: TextStyle(color: Colors.white)),
                  trailing: Icon(Icons.arrow_forward, color: Colors.white),
                ),
                ListTile(
                  onTap: () {
                    _auth.signOut();

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  leading: Icon(Icons.exit_to_app, color: Colors.white),
                  title: Text("Exit", style: TextStyle(color: Colors.white)),
                  subtitle:
                      Text("Logout", style: TextStyle(color: Colors.white)),
                  trailing: Icon(Icons.arrow_forward, color: Colors.white),
                )
              ],
            )));
  }
}
