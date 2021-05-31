import 'dart:convert';

class TopicModel {
  static final topic = [
    Topics(
        id: 1,
        name: "Indian Democracy",
        desc:
            "Democracy in India, as elsewhere, is not just about periodic elections, nor about voter turnouts, nor about oratory")
  ];
}

class Topics {
  final int id;
  final String name;
  final String desc;
  Topics({
    required this.id,
    required this.name,
    required this.desc,
  });
  Topics copyWith({
    int? id,
    String? name,
    String? desc,
  }) {
    return Topics(
      id: id ?? this.id,
      name: name ?? this.name,
      desc: desc ?? this.desc,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'desc': desc,
    };
  }

  factory Topics.fromMap(Map<String, dynamic> map) {
    return Topics(
      id: map['id'],
      name: map['name'],
      desc: map['desc'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Topics.fromJson(String source) => Topics.fromMap(json.decode(source));

  @override
  String toString() => 'Topics(id: $id, name: $name, desc: $desc)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Topics &&
        other.id == id &&
        other.name == name &&
        other.desc == desc;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ desc.hashCode;
}
