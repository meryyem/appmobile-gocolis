import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:gocolis/constants/error_handling.dart';
import 'package:gocolis/constants/global_variables.dart';
import 'package:gocolis/constants/utils.dart';
import 'package:gocolis/features/auth/sender/screens/sender_home.dart';
import 'package:gocolis/models/otpResponse.dart';
import 'package:gocolis/models/user.dart';
import 'package:gocolis/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
// SIGN UP USER ---------------------------------------------------------------------------------------------------------------------------
  void signUpUser({
    required BuildContext context,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String birthDate,
    required String? phoneNumber,
    String? userType = "sender",
    String? authType = "email",
  }) async {
    try {
      User user = User(
          authType: 'email',
          birthDate: birthDate,
          id: '',
          email: email,
          firstName: firstName,
          lastName: lastName,
          password: password,
          token: '',
          userType: 'sender');

      http.Response res = await http.post(Uri.parse('$uri/api/auth/register'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(
                context, 'Account created! Login with the same credentials!');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

// SIGN IN USER ---------------------------------------------------------------------------------------------------------------------------
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
    required VoidCallback onSuccess,
  }) async {
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/auth/login'),
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            onSuccess();
          } 
            
            /*SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            Navigator.pushNamedAndRemoveUntil(
                context, SenderHome.routeName, (route) => false);*/
          );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

// GET USER DATA ---------------------------------------------------------------------------------------------------------------------------
  void getUserData({
    required BuildContext context,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/api/auth/isTokenValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);
      if (response == true) {
        //get the user DATA
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // OTP CREATE && VERIFY -------------------------------------------------------------------------------------------------------
  static var client = http.Client();

  static Future<OTPResponse> CreateOtp(String phoneNumber) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var response = await client.post(Uri.parse('$uri/api/auth/otpCreate'),
        headers: requestHeaders, body: jsonEncode({"phone": phoneNumber}));

    return oTPResponseJSON(response.body);
  }

  static Future<OTPResponse> VerifyOtp(
    BuildContext context,
    String phoneNumber,
    String otpHash,
    String otpCode,
  ) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var response = await client.post(Uri.parse('$uri/api/auth/otpVerify'),
        headers: requestHeaders,
        body: jsonEncode({
          "phone": phoneNumber,
          "otp": otpCode,
          "hash": otpHash,
        }));

    httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          /* showSnackBar(
                context, 'Success');*/
        });
    return oTPResponseJSON(response.body);
  }

  /*void signUpSocialUser({
    required BuildContext context,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String birthDate,
    required String? phoneNumber,
    String? userType = "sender",
    String? authType = "fb&gmail",
    String? image,
  }) async {
    try {
      User user = User(
          authType: 'fb&gmail',
          birthDate: 'fb&gmail',
          id: '',
          email: email,
          firstName: firstName,
          lastName: 'fb&gmail',
          password: 'fb&&gmail',
          token: '',
          userType: 'sender',
          image: image);

      http.Response res = await http.post(Uri.parse('$uri/api/auth/socialRegister'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(
                context, 'Account created! Login with the same credentials!');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

// SIGN IN USER ---------------------------------------------------------------------------------------------------------------------------
  void signInSocialUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/auth/socialLogin'),
          body: jsonEncode({
            'email': email,
            'password': 'fb&&gmail',
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            Navigator.pushNamedAndRemoveUntil(
                context, SenderHome.routeName, (route) => false);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }*/

  void socialUser({
    required BuildContext context,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String birthDate,
    required String? phoneNumber,
    String? userType = "sender",
    String? authType = "fb&gmail",
    String? image,
  }) async {
    try {
      User user = User(
          authType: 'fb&gmail',
          birthDate: 'fb&gmail',
          id: '',
          email: email,
          firstName: firstName,
          lastName: 'fb&gmail',
          password: 'fb&&gmail',
          token: '',
          userType: 'sender',
          image: image);

      http.Response res = await http.post(Uri.parse('$uri/api/auth/social'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            //showSnackBar(context, 'Account created! Login with the same credentials!');
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            Navigator.pushNamedAndRemoveUntil(
                context, SenderHome.routeName, (route) => false);

            //Navigator.pushReplacementNamed(context, SenderHome.routeName);
            Navigator.popAndPushNamed(context, SenderHome.routeName);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

//--------------------------------------------------------------------------------------TRAVELER---------------------------------------------------------------
/*void signInTraveler({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/auth/login'),
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            Navigator.pushNamedAndRemoveUntil(
                context, TravelerHome.routeName, (route) => false);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }*/
}
