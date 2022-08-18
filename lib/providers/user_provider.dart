import 'package:flutter/material.dart';
import 'package:gocolis/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      id: '',
      authType: '',
      userType: '',
      firstName: '',
      lastName: '',
      email: '',
      password: '',
      birthDate: '',
      phoneNumber: '',
      token: '');

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }
  }
