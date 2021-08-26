import 'package:flutter/material.dart';
import 'package:mymusic/widgets/DataWidget.dart';

class PlayMusic extends StatefulWidget {
  final Songs contents;
  const PlayMusic({
    Key? key,
    required this.contents,
  }) : super(key: key);

  @override
  _PlayMusicState createState() => _PlayMusicState();
}

class _PlayMusicState extends State<PlayMusic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title:
              Text("${widget.contents.name} by ${widget.contents.description}"),
        ),
        body: Container(
            margin: EdgeInsets.all(40),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  children: [Image.network(widget.contents.image)],
                ))));
  }
}
