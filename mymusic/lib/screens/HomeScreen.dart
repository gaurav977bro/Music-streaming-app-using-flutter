import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mymusic/widgets/MyDrawer.dart';
import 'package:mymusic/widgets/SongWidget.dart';

import 'LoginScreen.dart';
import 'MusicScreen.dart';

void main() {
  runApp(Home());
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    load();
  }

  load() async {
    var data = await rootBundle.loadString("assets/data/songs.json");
    var decodedData = jsonDecode(data);
    var productData = decodedData["songs"];

    SongsWidget.songList = List.of(productData)
        .map<Songs>((songs) => Songs.fromMap(songs))
        .toList();
    setState(() {});
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: My_Drawer(),
        // Drawer(
        //     child: Container(
        //         decoration: BoxDecoration(
        //             gradient: LinearGradient(
        //                 colors: [Colors.black, Colors.blue],
        //                 begin: Alignment.topLeft,
        //                 end: Alignment.bottomRight)))),
        appBar: AppBar(),
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.blue,
              Colors.black,
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
            child: SafeArea(
                child: Container(
                    width: double.infinity,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [Colors.blue, Colors.black],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight)),
                              padding:
                                  EdgeInsets.only(top: 5, left: 10, bottom: 5),
                              child: Text("Songs....",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20))),
                          Expanded(child: SongList()),
                        ])))));
  }
}

class SongList extends StatefulWidget {
  const SongList({Key? key}) : super(key: key);

  @override
  _SongListState createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final item = SongsWidget.songList[index];
        return Card(
            elevation: 10,
            shadowColor: Colors.black,
            color: Colors.black,
            child: ListTile(
              contentPadding: EdgeInsets.all(20),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Player(contents: item)));
              },
              leading: Container(
                width: 100,
                child: Image.network(item.image),
              ),
              title: Text(
                item.name,
                style: TextStyle(color: Colors.white),
              ),
              subtitle:
                  Text(item.description, style: TextStyle(color: Colors.white)),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)));
      },
      itemCount: SongsWidget.songList.length,
    );
  }
}
