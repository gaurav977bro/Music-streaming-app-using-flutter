import 'dart:convert';

class SongsWidget {
  static List<Songs> songList = [];
}

class Songs {
  final int id;
  final String url;
  final String name;
  final String image;
  final String description;
  Songs({
    required this.id,
    required this.url,
    required this.name,
    required this.image,
    required this.description,
  });

  Songs copyWith({
    int? id,
    String? url,
    String? name,
    String? image,
    String? description,
  }) {
    return Songs(
      id: id ?? this.id,
      url: url ?? this.url,
      name: name ?? this.name,
      image: image ?? this.image,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'url': url,
      'name': name,
      'image': image,
      'description': description,
    };
  }

  factory Songs.fromMap(Map<String, dynamic> map) {
    return Songs(
      id: map['id'],
      url: map['url'],
      name: map['name'],
      image: map['image'],
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Songs.fromJson(String source) => Songs.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Songs(id: $id, url: $url, name: $name, image: $image, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Songs &&
        other.id == id &&
        other.url == url &&
        other.name == name &&
        other.image == image &&
        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        url.hashCode ^
        name.hashCode ^
        image.hashCode ^
        description.hashCode;
  }
}
