import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gocolis/features/auth/sender/screens/sender_home.dart';
import 'package:gocolis/features/messages/screens/chat_login_screen.dart';
import 'package:gocolis/features/messages/screens/chat_page.dart';
import 'package:gocolis/features/messages/screens/individual_page.dart';
import 'package:gocolis/features/messages/screens/login_page.dart';
import 'package:gocolis/features/messages/screens/message_home.dart';
import 'package:gocolis/features/messages/screens/select_contact.dart';
import 'package:gocolis/features/messages/screens/status_page.dart';

class PhoneService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final storage = FlutterSecureStorage();
  Future<void> verifyPhoneNumber(
      String phoneNumber, BuildContext context, Function setData) async {
    // ignore: prefer_function_declarations_over_variables
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      showSnackBar(context, "Verification Completed");
    };

    // if some exception happen and firebase is not able to send the sms
    // code in your device at this time this handler will be called !!
    // ignore: prefer_function_declarations_over_variables
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exception) {
      showSnackBar(context, exception.toString());
    };

    //the verificationId is required when the user is logged in firebase
    // ignore: prefer_function_declarations_over_variables
    PhoneCodeSent codeSent =
        (String verificationID, [int? forceResendingToken]) {
      showSnackBar(context, "Verification Code Sent On The Phone Number");
      // just after sending the sms code on a phone number here in a code
      // i want to set the data and provide the verification id and start the timer just after sending the code
      setData(verificationID);
    };

    //basically in android we support an automatic sms retrieval that it still listenning for a certain timeout
    // ignore: prefer_function_declarations_over_variables
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationID) {
      showSnackBar(context, "Time Out !");
    };
    // after the sms will be sent
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> signInWithPhoneNumber(
      String verificationIDFinal, String smsCode, BuildContext context, Function onTap, Function onSendImage) async {
    try {
      // iam getting the credential of the user with the help of the phone provider
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationIDFinal, smsCode: smsCode);
      // and passing the same cedential on to the firebase
      UserCredential userPhone = await _auth.signInWithCredential(credential);
      //function to store the data in your backend
      //here nrmlt we store it in the firebase !!
      storeData(userPhone);
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => ChatLoginScreen(onTap: onTap, onImageSend: onSendImage)),
          (route) => false);

      // ignore: use_build_context_synchronously
      showSnackBar(context, "logged in");
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void storeData(UserCredential userPhone) async {
    print('storing data');
    await storage.write(key: "userPhone", value: userPhone.toString());
  }
}
