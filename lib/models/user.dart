import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final String id;
  final String authType;
  final String userType;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String birthDate;
  final String? phoneNumber;
  final String? image;
  final String token;
  User({
    required this.id,
    required this.authType,
    required this.userType,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.birthDate,
    this.phoneNumber,
    required this.token,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'authType': authType,
      'userType': userType,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'birthDate': birthDate,
      'image': image,
      'phoneNumber': phoneNumber,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] as String,
      authType: map['authType'] as String,
      userType: map['userType'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      birthDate: map['birthDate'] as String,
      image: map['image'] != null ? map['image'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
