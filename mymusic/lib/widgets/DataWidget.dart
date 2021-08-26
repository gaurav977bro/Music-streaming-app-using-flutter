import 'dart:convert';

class SongsWidget {
  static final Songlist = [];
}

class Songs {
  int id;
  String name;
  String url;
  String image;

  Songs(
      {required this.id,
      required this.name,
      required this.url,
      required this.image});
}
