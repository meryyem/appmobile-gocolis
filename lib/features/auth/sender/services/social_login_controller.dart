/*import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:gocolis/features/auth/authSignUp/services/authService.dart';
import 'package:gocolis/features/auth/sender/services/sender_services.dart';
import 'package:gocolis/models/user.dart';
import 'package:gocolis/providers/user_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class SocialLoginController with ChangeNotifier {
  //---------------------------------------------------------GOOGLE--------------------------------------------------------------
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

  /*senderServices.socialRegister(
        context: context, email: user!.email, password: 'fb&&gmail', birthDate: 'fb&gmail', firstName: user!.firstName, lastName: 'fb&gmail', phoneNumber: '');*/

  //--------------------------------------------------------------FACEBOOK--------------------------------------------------------

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

    logOut() async {
      googleAccount = await _googleSignIn.signOut();
      await FacebookAuth.i.logOut();
      user = null;
      notifyListeners();
    }
  }
}*/
