class Note {
  String? id;
  String name;
  String description;

  Note({
    this.id,
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  static Note fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}
