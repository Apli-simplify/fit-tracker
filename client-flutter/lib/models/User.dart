class User {
  final String? id;
  String? name;
  String email;
  String? password;
  String? gender;
  int? age;

  User({
    this.id,
    this.name,
    required this.email,
    this.password,
    this.gender,
    required this.age,
  });

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, password: $password, gender: $gender}';
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
        'gender': gender,
      };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      gender: json['gender'],
      age: json['age'],
    );
  }
}
