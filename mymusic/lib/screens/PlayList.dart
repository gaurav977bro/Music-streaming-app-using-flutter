import 'package:flutter/material.dart';
import 'package:mymusic/widgets/SongWidget.dart';

class playList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.red, Colors.black],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
          child: SingleChildScrollView(
              child: Column(
            children: [
              SongsGrid(),
            ],
          ))),
    );
  }
}

class SongsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: SongsWidget.songList.length,
        itemBuilder: (context, index) {
          final x = SongsWidget.songList[index];
          return GridTile(
              child: Container(
                  child: Column(
            children: [
              Container(child: Image.network(x.image)),
            ],
          )));
        });
  }
}
