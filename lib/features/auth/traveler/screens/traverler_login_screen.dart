import 'package:flutter/material.dart';
import 'package:gocolis/common/widgets/custom_button.dart';
import 'package:gocolis/common/widgets/custom_text_field.dart';
import 'package:gocolis/constants/colors.dart';
import 'package:gocolis/features/auth/authSignUp/screens/signup_screen.dart';
import 'package:gocolis/features/auth/authSignUp/services/authService.dart';
import 'package:gocolis/features/auth/traveler/screens/traveler_home.dart';

class TravelerLoginScreen extends StatefulWidget {
  static const routeName = '/login-traveler-screen';
  const TravelerLoginScreen({Key? key}) : super(key: key);

  @override
  State<TravelerLoginScreen> createState() => _TravelerLoginScreenState();
}

class _TravelerLoginScreenState extends State<TravelerLoginScreen> {
  final _signinFormKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //instance of authService class
  final AuthService authService = AuthService();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void signinUser() {
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      onSuccess: () async {
        await Navigator.pushNamedAndRemoveUntil(
            context, TravelerHome.routeName, (route) => false);
      }
    );
  }

  void navigateToSignUpScreen(BuildContext context) {
    Navigator.pushNamed(context, SignUpScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: double.infinity,
          child: Form(
            key: _signinFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.15),
                Stack(alignment: Alignment.center, children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "LOGIN",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: kPrimaryColor,
                          ),
                        ),
                        SizedBox(height: size.height * 0.15),
                        Column(children: [
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
                            controller: _passwordController,
                            obscureText: true,
                            boxColor: kPrimaryLightColor,
                            icon: Icons.lock,
                            iconColor: kPrimaryColor,
                            hintText: "Password",
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
                                text: 'LOGIN',
                                textColor: Colors.white,
                                onPressed: () {
                                  if (_signinFormKey.currentState!.validate()) {
                                    signinUser();
                                  }
                                },
                                color: kPrimaryColor,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Not a member yet? ",
                                    style: TextStyle(color: kPrimaryColor),
                                  ),
                                  GestureDetector(
                                    onTap: () => navigateToSignUpScreen(context),
                                    child: const Text(
                                      " Sign up",
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
                ]
              ),
            ]
          ),
        ),
      ),
    ));
  }
}