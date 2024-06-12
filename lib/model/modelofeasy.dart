import 'dart:convert';

class Easydata {
  String name;
  String description;
  Easydata({
    required this.name,
    required this.description,
  });

  Easydata copyWith({
    String? name,
    String? description,
  }) {
    return Easydata(
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
    };
  }

  factory Easydata.fromMap(Map<String, dynamic> map) {
    return Easydata(
      name: map['name'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Easydata.fromJson(String source) =>
      Easydata.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Easydata(name: $name, description: $description)';

  @override
  bool operator ==(covariant Easydata other) {
    if (identical(this, other)) return true;

    return other.name == name && other.description == description;
  }

  @override
  int get hashCode => name.hashCode ^ description.hashCode;
}
