import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:gocolis/features/auth/authSignUp/services/authService.dart';
import 'package:gocolis/models/user.dart';

class FacebookSignINController with ChangeNotifier {
  BuildContext? context;

  User? user;
  AuthService authServices = AuthService();

  facebookLogin({required BuildContext context}) async {
    var result = await FacebookAuth.i.login(
      permissions: ["public_profile", "email"],
    );

    if (result.status == LoginStatus.success) {
      final requestData = await FacebookAuth.i.getUserData(
        fields: "email, name, picture",
      );

      user = User(
        userType: 'sender',
        authType: 'fb&gmail',
        lastName: 'fb&gmail',
        id: '',
        birthDate: 'fb&gmail',
        password: 'fb&&gmail',
        token: '',
        phoneNumber: '',
        firstName: requestData["name"],
        email: requestData["email"],
        image: requestData["picture"]["data"]["url"] ?? '',
      );

      //senderServices.socialLogin(
      //context: context, email: user!.email, password: 'fb&&gmail');

      authServices.socialUser(
        context: context,
        email: user!.email,
        password: 'fb&&gmail',
        birthDate: 'fb&gmail',
        firstName: user!.firstName,
        lastName: 'fb&gmail',
        phoneNumber: '',
        image: user!.image,
      );

      notifyListeners();
    }
  }

  logOut() async {
    await FacebookAuth.i.logOut();
    user = null;
    notifyListeners();
    /*Map? userData;

  login() async {
    var result = await FacebookAuth.i.login(
      permissions: ["public_profile", "email"],
    );

    if (result.status == LoginStatus.success) {
      final requestData = await FacebookAuth.i.getUserData(
        fields: "email, name, picture",
      );

      userData = requestData;
      notifyListeners();
    }
  }

  logOut() async {
    await FacebookAuth.i.logOut();
    userData = null;
    notifyListeners();
  }*/
  }
}
