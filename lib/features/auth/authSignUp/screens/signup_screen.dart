import 'package:flutter/material.dart';
import 'package:gocolis/common/widgets/custom_button.dart';
import 'package:gocolis/common/widgets/custom_text_field.dart';
import 'package:gocolis/constants/colors.dart';
import 'package:gocolis/features/auth/authSignUp/screens/otp_screen.dart';
import 'package:gocolis/features/auth/sender/screens/sender_login_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup-screen';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _signupFormKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _birthDateController.dispose();
    _passwordController.dispose();
  }

  void navigateToLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, SenderLoginScreen.routeName);
  }

  /*void navigateToOTPScreen(
    BuildContext context,
    String firstName,
    String lastName,
    String email,
    String password,
    String birthDate,
  ) {
    Navigator.pushNamed(context, OTPScreen.routeName,
        arguments: [firstName, lastName, password, email, birthDate]);
  }*/

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: SafeArea(
      //height: size.height,
      //width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _signupFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.05),
                const Text(
                  "SIGN UP",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: kPrimaryColor,
                  ),
                ),
                SizedBox(height: size.height * 0.1),
                Column(children: [
                  CustomTextField(
                    controller: _firstNameController,
                    obscureText: false,
                    boxColor: kPrimaryLightColor,
                    icon: Icons.person,
                    iconColor: kPrimaryColor,
                    hintText: "First Name",
                    onChanged: (value) {},
                  ),
                  CustomTextField(
                    controller: _lastNameController,
                    obscureText: false,
                    boxColor: kPrimaryLightColor,
                    icon: Icons.person_outline,
                    iconColor: kPrimaryColor,
                    hintText: "Last Name",
                    onChanged: (value) {},
                  ),
                  CustomTextField(
                    controller: _emailController,
                    obscureText: false,
                    boxColor: kPrimaryLightColor,
                    icon: Icons.mail,
                    iconColor: kPrimaryColor,
                    hintText: "Email",
                    onChanged: (value) {},
                  ),
                  CustomTextField(
                    controller: _birthDateController,
                    obscureText: false,
                    boxColor: kPrimaryLightColor,
                    icon: Icons.date_range,
                    iconColor: kPrimaryColor,
                    hintText: "Birth Date",
                    onChanged: (value) {},
                  ),
                  CustomTextField(
                    controller: _passwordController,
                    obscureText: true,
                    boxColor: kPrimaryLightColor,
                    icon: Icons.lock,
                    iconColor: kPrimaryColor,
                    hintText: "Password",
                    //It must have at least 8 characters, 1 letter, 1 number and 1 special character
                    onChanged: (value) {},
                    suffixIcon: const Icon(
                      Icons.visibility,
                      color: kPrimaryColor,
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                  Container(
                    alignment: Alignment.center,
                    child: Column(children: [
                      CustomButton(
                        boxColor: kPrimaryLightColor,
                        text: 'NEXT',
                        textColor: Colors.white,
                        onPressed: () {
                          if (_signupFormKey.currentState!.validate()) {
                            /*navigateToOTPScreen(
                              context,
                              _firstNameController.text,
                              _lastNameController.text,
                               _emailController.text,
                               _passwordController.text,
                               _birthDateController.text,
                            );*/

                            Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OTPScreen(
                                      firstName: _firstNameController.text,
                                      lastName: _lastNameController.text,
                                      email:  _emailController.text,
                                      password: _passwordController.text,
                                      birthDate: _birthDateController.text,
                                    ),
                                  ),
                                  (route) => false,
                                );
                          }
                        },
                        color: kPrimaryColor,
                        //if(_signUpFormKey.currentState!.validate())
                        //{ signupUser();}
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already a member ? ",
                            style: TextStyle(color: kPrimaryColor),
                          ),
                          GestureDetector(
                            onTap: () {
                              navigateToLoginScreen(context);
                            },
                            child: const Text(
                              " Log in",
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
                  SizedBox(height: size.height * 0.05),
                ]),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
