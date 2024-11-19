class User {
  final int? id;
  String? firstname;
  String? lastname;
  String email;
  String? password;
  bool? gender;
  double? weight;
  double? height;
  User({
    this.id,
    this.firstname,
    this.lastname,
    required this.email,
    this.password,
    this.gender,
    this.weight,
    this.height,
  });

  @override
  String toString() {
    return 'User{id: $id, firstname: $firstname, lastname: $lastname, email: $email, password: $password, gender: $gender, weight: $weight, height: $height}';
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'password': password,
        'gender': gender,
        'weight': weight,
        'height': height,
      };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      password: json['password'],
      gender: json['gender'],
      weight: json['weight'],
      height: json['height'],
    );
  }
}
