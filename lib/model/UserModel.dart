class Usermodel {
  final String id;
  final String name;
  final String email;
  final String password;
 

  Usermodel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
   
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    
    };
  }

  factory Usermodel.fromMap(Map<String, dynamic> json) {
    return Usermodel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
   
    );
  }
}
