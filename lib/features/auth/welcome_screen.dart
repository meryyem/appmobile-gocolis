import 'package:flutter/material.dart';
import 'package:gocolis/common/widgets/custom_button.dart';
import 'package:gocolis/constants/colors.dart';
import 'package:gocolis/features/auth/authSignUp/screens/signup_screen.dart';
import 'package:gocolis/features/auth/sender/screens/sender_login_screen.dart';
import 'package:gocolis/features/auth/traveler/screens/traverler_login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  void navigateToSenderLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, SenderLoginScreen.routeName);
  }

  void navigateToTravelerLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, TravelerLoginScreen.routeName);
  }

  void navigateToSignUpScreen(BuildContext context) {
    Navigator.pushNamed(context, SignUpScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //appBar: AppBar(title: Text ('hello')),
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "WELCOME TO GOCOLIS",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: kPrimaryColor,
                ),
              ),
              SizedBox(height: size.height * 0.5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomButton(
                    boxColor: kPrimaryColor,
                    color:kPrimaryLightColor,
                    text: 'LOGIN', 
                    onPressed: () => navigateToSenderLoginScreen(context),
                    textColor: kPrimaryColor,
                  ),
                  CustomButton(
                    boxColor: kPrimaryLightColor,
                    text: 'SIGN UP', 
                    textColor: kPrimaryLightColor,
                    onPressed: () => navigateToTravelerLoginScreen(context),
                    color: kPrimaryColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
