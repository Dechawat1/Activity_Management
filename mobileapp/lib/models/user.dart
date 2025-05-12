import 'dart:convert';

class UserModel {
  final String name;
  final String email;
  final String password;
  final String imageUrl;
  final String phone;

  UserModel(
      {required this.name,
      required this.email,
      required this.password,
      required this.imageUrl,
        required this.phone});

  UserModel copyWith({
    String? name,
    String? email,
    String? password,
    String? imageUrl,
    String? phone,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      imageUrl: imageUrl ?? this.imageUrl,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'imageUrl': imageUrl,
      'phone': phone,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      imageUrl: map['imageUrl'] as String,
      phone: map['phone'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'UserModel(name: $name, email: $email, password: $password, imageUrl: $imageUrl, phone: $phone)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.password == password &&
        other.imageUrl == imageUrl&&
        other.phone == phone;
  }

  @override
  int get hashCode =>
      name.hashCode ^ email.hashCode ^ password.hashCode ^ imageUrl.hashCode^ phone.hashCode;
}
