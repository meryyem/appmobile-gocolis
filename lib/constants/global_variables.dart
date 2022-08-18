// android emulator -------------------
//String uri = 'http://10.0.2.2:3000';
// android phone ----------------------
import 'package:flutter/material.dart';

String uri = 'http://192.168.1.14:3000';
String otpCreateApi = '/api/auth/otpCreate';
String otpVerifyApi = '/api/auth/otpVerify';

class GlobalVariables {
  //COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromRGBO(244, 180, 26, 1),
       Color.fromRGBO(252, 199, 41, 1)
    ],
    stops: [0.5, 1.0],
  );
}
