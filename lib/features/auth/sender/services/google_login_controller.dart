import 'package:flutter/material.dart';
import 'package:gocolis/features/auth/authSignUp/services/authService.dart';
import 'package:gocolis/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignINController with ChangeNotifier {
  var _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleAccount;
  BuildContext? context;

  User? user;
  AuthService authServices = AuthService();
  googleLogin({required BuildContext context}) async {
    googleAccount = await _googleSignIn.signIn();
    user = User(
      userType: 'sender',
      authType: 'fb&gmail',
      lastName: 'fb&gmail',
      id: '',
      birthDate: 'fb&gmail',
      password: 'fb&&gmail',
      token: '',
      firstName: googleAccount!.displayName ?? '',
      email: googleAccount!.email,
      image: googleAccount!.photoUrl,
    );

    /*void social (
    BuildContext context
  ) {*/
    /*final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (user!.email != googleAccount!.email) {
      authServices.signUpSocialUser(
          context: context,
          email: user!.email,
          password: 'fb&&gmail',
          birthDate: 'fb&gmail',
          firstName: user!.firstName,
          lastName: 'fb&gmail',
          phoneNumber: '',
          image: user!.image,);
    } else {
      authServices.signInSocialUser(
        context: context,
        email: user!.email,
        password: 'fb&&gmail',
      );
    }*/
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

  logout() async {
    this.googleAccount = await _googleSignIn.signOut();
    notifyListeners();

    /*var _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleAccount;

  login() async {
    this.googleAccount = await _googleSignIn.signIn();
    notifyListeners();
  }

  logout() async {
    this.googleAccount = await _googleSignIn.signOut();
    notifyListeners();
  }*/
  }
}
