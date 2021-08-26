import 'dart:convert';

class SongsWidget {
  static List<Songs> Songlist = [];
}

class Songs {
  final int id;
  final String image;
  final String name;
  final String description;

  Songs({
    required this.id,
    required this.image,
    required this.name,
    required this.description,
  });

  Songs copyWith({
    int? id,
    String? image,
    String? name,
    String? description,
  }) {
    return Songs(
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'description': description,
    };
  }

  factory Songs.fromMap(Map<String, dynamic> map) {
    return Songs(
      id: map['id'],
      image: map['image'],
      name: map['name'],
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Songs.fromJson(String source) => Songs.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Songs(id: $id, image: $image, name: $name, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Songs &&
        other.id == id &&
        other.image == image &&
        other.name == name &&
        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^ image.hashCode ^ name.hashCode ^ description.hashCode;
  }
}
