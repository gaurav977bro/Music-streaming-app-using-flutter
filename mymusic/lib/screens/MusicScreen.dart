// ignore: import_of_legacy_library_into_null_safe
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mymusic/widgets/SongWidget.dart';

class Player extends StatefulWidget {
  final Songs items;
  const Player({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  bool played = false;
  AudioPlayer audioPlayer = new AudioPlayer();
  Duration duration = new Duration();
  Duration position = new Duration();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.black, Colors.blue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Text("My Music",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold)),
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Text("Listen to your favourite beats...",
                    style: TextStyle(color: Colors.white, fontSize: 15)),
              ),
              picture(),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  widget.items.name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Text(widget.items.description,
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
              SizedBox(
                height: 30,
              ),
              Controller()
            ],
          ))),
    );
  }

  Card picture() {
    return Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10,
        margin: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 20),
        shadowColor: Colors.black,
        child: Container(
            width: double.infinity,
            child: Image.network(widget.items.image,
                filterQuality: FilterQuality.high, fit: BoxFit.fill)));
  }

  Controller() {
    return Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, -10), color: Colors.black, blurRadius: 30)
            ],
            gradient: LinearGradient(
                colors: [Colors.black, Colors.blue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(40), topLeft: Radius.circular(40))),
        child: Column(
          // CONTROLLER
          children: [
            SizedBox(height: 30),
            Text(widget.items.name,
                style: TextStyle(color: Colors.white, fontSize: 25)),
            SizedBox(height: 30),
            // SLIDER
            Slider.adaptive(
              min: 0.0,
              value: position.inSeconds.toDouble(),
              max: duration.inSeconds.toDouble(),
              onChanged: (value) {
                setState(() {
                  audioPlayer.seek(new Duration(seconds: value.toInt()));
                });
              },
              inactiveColor: Colors.white,
              activeColor: Colors.white,
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SizedBox(width: 20),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.fast_rewind, color: Colors.white, size: 60),
                  iconSize: 80,
                ),
                SizedBox(width: 30),
                IconButton(
                  onPressed: () {
                    getAudio();
                  },
                  icon: Icon(played ? Icons.pause : Icons.play_arrow,
                      color: Colors.white, size: 60),
                  iconSize: 80,
                ),
                SizedBox(width: 30),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.fast_forward, color: Colors.white, size: 60),
                  iconSize: 80,
                )
              ],
            )
          ],
        ));
  }

  void getAudio() async {
    if (played) {
      var res = await audioPlayer.pause();
      if (res == 1) {
        setState(() {
          played = false;
        });
      }
    } else {
      var res =
          await audioPlayer.play(widget.items.url.toString(), isLocal: false);
      if (res == 1) {
        setState(() {
          played = true;
        });
      }
    }
    audioPlayer.onDurationChanged.listen((Duration dd) {
      setState(() {
        this.duration = dd;
      });
    });

    audioPlayer.onAudioPositionChanged.listen((Duration dd) {
      setState(() {
        this.position = dd;
      });
    });
  }
}
