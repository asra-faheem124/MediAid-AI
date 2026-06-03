class Usermodel {
  final String id;
  final String name;
  final String email;
  final String? imageUrl;

  Usermodel({
    required this.id,
    required this.name,
    required this.email,
    this.imageUrl,
  });
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'email': email, 'imageUrl': imageUrl};
  }

  factory Usermodel.fromMap(Map<String, dynamic> json) {
    return Usermodel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      imageUrl: json['imageUrl'],
    );
  }
}
