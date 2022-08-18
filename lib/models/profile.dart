// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Profile {
  final String firstName;
  final String lastName;
  final String email;
  final String birthDate;
  final String? image;
  final String? phoneNumber;
  final String? password;
  final String? authType;
  final String? userType;
  final String? id;
  final String? userId;
  Profile({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.birthDate,
    this.image,
    this.phoneNumber,
    this.password,
    this.authType,
    this.userType,
    this.id,
    this.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'image': image,
      'birthDate': birthDate,
      'phoneNumber': phoneNumber,
      'password': password,
      'authType': authType,
      'userType': userType,
      'id': id,
      'userId': userId,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      image: map['image'] as String,
      birthDate: map['birthDate'] as String,
      phoneNumber: map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      authType: map['authType'] != null ? map['authType'] as String : null,
      userType: map['userType'] != null ? map['userType'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) => Profile.fromMap(json.decode(source) as Map<String, dynamic>);
}
