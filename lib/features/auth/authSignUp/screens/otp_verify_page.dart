import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gocolis/common/widgets/custom_button.dart';
import 'package:gocolis/constants/colors.dart';
import 'package:gocolis/features/auth/authSignUp/services/authService.dart';
import 'package:gocolis/features/home/screens/home_screen.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpVerifyScreen extends StatefulWidget {
  final String? phoneNumber;
  final String? otpHash;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String birthDate;

  const OtpVerifyScreen(
      {Key? key,
      this.phoneNumber,
      this.otpHash,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      required this.birthDate})
      : super(key: key);

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  final _otpVerifyFormKey = GlobalKey<FormState>();
  String _otpCode = '';
  final int _otpCodeLength = 4;
  bool isAPICallProcess = false;
  late FocusNode myFocusNode;
  String userType = "livreur";
  String authType = "email";

  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    myFocusNode.requestFocus();

    SmsAutoFill().listenForCode.call();
  }

  void signupUser() {
    authService.signUpUser(
      context: context,
      phoneNumber: widget.phoneNumber,
      firstName: widget.firstName,
      lastName: widget.lastName,
      email: widget.email,
      password: widget.password,
      birthDate: widget.birthDate,
    );
  }

  void navigateToHomeScreen(BuildContext context) {
    Navigator.pushNamed(context, HomeScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verifying your phone number"),
        elevation: 0,
        backgroundColor: kPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _otpVerifyFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.4,
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: PinFieldAutoFill(
                      decoration: UnderlineDecoration(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          color: kPrimaryColor,
                        ),
                        colorBuilder:
                            FixedColorBuilder(Colors.black.withOpacity(.3)),
                      ),
                      currentCode: _otpCode,
                      codeLength: _otpCodeLength,
                      onCodeChanged: (code) {
                        if (code!.length == _otpCodeLength) {
                          _otpCode = code;
                          FocusScope.of(context).requestFocus(FocusNode());
                        }
                      })),
              SizedBox(
                height: size.height * 0.05,
              ),
              SizedBox(
                width: size.width * 0.6,
                child: CustomButton(
                  onPressed: () {
                    //if(_otpVerifyFormKey.currentState!.validate()) {
                    setState(() {
                      isAPICallProcess = true;
                    });

                    AuthService.VerifyOtp(
                      context,
                      widget.phoneNumber!,
                      widget.otpHash!,
                      _otpCode,
                    ).then((response) async {
                      setState(() {
                        isAPICallProcess = false;
                      });
                      print(widget.firstName);
                      print(response.message);

                      if (response.data != null) {
                        signupUser();
                        navigateToHomeScreen(context);
                        /*await Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(
                              firstName: widget.firstName,
                              lastName: widget.lastName,
                              email: widget.email,
                              password: widget.password,
                              birthDate: widget.birthDate,
                              phoneNumber: widget.phoneNumber,
                            ),
                          ),
                          (route) => false,
                        );*/
                      }
                    });
                    // }
                  },
                  boxColor: kPrimaryColor,
                  text: 'SIGN UP',
                  textColor: kPrimaryLightColor,
                  color: kPrimaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*void showCustomAlertDialog(BuildContext context, OTPResponse response) {
    CustomAlertDialog(
      onTap: () {
        Navigator.pop(context);
      },
      text: response.message,
    );
  }*/

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    myFocusNode.dispose();
    super.dispose();
  }
}
