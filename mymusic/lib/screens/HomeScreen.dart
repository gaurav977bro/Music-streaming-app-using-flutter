import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mymusic/screens/Player.dart';
import 'package:mymusic/widgets/DataWidget.dart';

import 'LoginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Home());
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
  }

  load() async {
    final data = await rootBundle.loadString("assets/data/songs.json");
    final decodedData = jsonDecode(data);
    var productData = decodedData["songs"];

    SongsWidget.Songlist = List.of(productData)
        .map<Songs>((songs) => Songs.fromMap(songs))
        .toList();

    setState(() {});
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
            child: Container(
          color: Colors.blue,
          child: Column(
            children: [
              Container(
                child: DrawerHeader(
                    child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[900],
                      borderRadius: BorderRadius.circular(10)),
                  child: UserAccountsDrawerHeader(
                    currentAccountPictureSize: Size(50, 50),
                    accountEmail: Text("email"),
                    accountName: Text("name"),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://i1.wp.com/azsongslyrics.com/wp-content/uploads/2020/05/Sunflower-lyrics-Post-Malone.jpg?fit=1280%2C720&ssl=1"),
                    ),
                  ),
                )),
              ),
              SizedBox(height: 30),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.settings, color: Colors.white),
                title: Text("Settings", style: TextStyle(color: Colors.white)),
                subtitle: Text("account settings",
                    style: TextStyle(color: Colors.white)),
                trailing: Icon(Icons.arrow_forward, color: Colors.white),
              ),
              ListTile(
                onTap: () {
                  _auth.signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
                leading: Icon(Icons.logout, color: Colors.white),
                title: Text("Exit", style: TextStyle(color: Colors.white)),
                subtitle: Text("Logout", style: TextStyle(color: Colors.white)),
                trailing: Icon(Icons.arrow_forward, color: Colors.white),
              )
            ],
          ),
        )),
        backgroundColor: Colors.blueGrey[900],
        appBar: AppBar(
          title: Text("Songs"),
        ),
        body: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 20, top: 5),
              child: Text("Trending.....",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(child: SongList()),
          ],
        )));
  }
}

class SongList extends StatefulWidget {
  @override
  _SongListState createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final items = SongsWidget.Songlist[index];
        return Card(
          margin: EdgeInsets.only(right: 5, left: 5, top: 0, bottom: 5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 5,
          shadowColor: Colors.blue,
          clipBehavior: Clip.hardEdge,
          color: Colors.black,
          borderOnForeground: true,
          child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PlayMusic(contents: items)));
              },
              contentPadding: EdgeInsets.all(20),
              leading: Container(width: 100, child: Image.network(items.image)),
              title: Text(items.name, style: TextStyle(color: Colors.white)),
              subtitle: Text(items.description,
                  style: TextStyle(color: Colors.white))),
        );
      },
      itemCount: SongsWidget.Songlist.length,
    );
  }
}
