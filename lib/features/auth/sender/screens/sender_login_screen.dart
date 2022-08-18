import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gocolis/common/widgets/custom_button.dart';
import 'package:gocolis/common/widgets/custom_text_field.dart';
import 'package:gocolis/constants/colors.dart';
import 'package:gocolis/features/auth/authSignUp/screens/signup_screen.dart';
import 'package:gocolis/features/auth/authSignUp/services/authService.dart';
import 'package:gocolis/features/auth/sender/screens/sender_home.dart';
import 'package:gocolis/features/auth/sender/services/facebook_login_controller.dart';
import 'package:gocolis/features/auth/sender/services/google_login_controller.dart';
import 'package:gocolis/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SenderLoginScreen extends StatefulWidget {
  static const routeName = '/login-sender-screen';
  const SenderLoginScreen({Key? key}) : super(key: key);

  @override
  State<SenderLoginScreen> createState() => _SenderLoginScreenState();
}

class _SenderLoginScreenState extends State<SenderLoginScreen> {
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
            context, SenderHome.routeName, (route) => false);
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
        /*child: SizedBox(
          height: size.height * 0.95,
          width: double.infinity,*/
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
                                    onTap: () =>
                                        navigateToSignUpScreen(context),
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
                ]),
                //const OrDivider(),
                //----------------------------------------------------------------
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: size.width * 0.8,
                      child:
                          Stack(alignment: Alignment.center, children: const [
                        Divider(
                          color: kPrimaryColor,
                          height: 1.5,
                        ),
                        Text(
                          "OR",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w600,
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ]),
                    ),
                    SizedBox(height: size.height * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        loginUIFacebook(),
                        loginUIGoogle(),
                      ]
                    )
                    
                    //loginControlsFacebook(context),
                    /*Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Provider.of<SocialLoginController>(context,
                                    listen: false)
                                .facebookLogin(context: context);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: kPrimaryColor,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset("assets/icons/facebook.svg",
                                height: 20, width: 20, color: kPrimaryColor),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Provider.of<SocialLoginController>(context,
                                    listen: false)
                                .googleLogin(context: context);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: kPrimaryColor,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                                "assets/icons/google-plus.svg",
                                height: 20,
                                width: 20,
                                color: kPrimaryColor),
                          ),
                        ),
                      ],
                    ),*/
                    /*SizedBox(
                    height: 60,
                    child: InkWell(onTap: () {
                      loginUI();
                    }))*/
                  ],
                ),
              ],
            ),
          ),
        ),
      //),
    );
  }

  loginUIFacebook() {
    return Consumer<FacebookSignINController>(builder: (context, model, child) {
      if (model.user != null) {
        return Center(
          child: loggedInUIFacebook(model, context),
        );
      } else {
        //return Text("null");
        return loginControlsFacebook(context);
      }
    });
  }

  loggedInUIFacebook(FacebookSignINController model, BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: Image.network(model.user!.image ?? '').image,
              radius: 50,
            ),
            Text(model.user!.firstName),
            Text(model.user!.email),
            ActionChip(
                avatar: Icon(Icons.logout),
                label: Text("Logout"),
                onPressed: () {

                  Provider.of<FacebookSignINController>(context, listen: false)
                      .logOut();
                }),
          ]),
    );
  }

  //login images here => facebook and google //to add in the orDivider part !!
  loginControlsFacebook(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
             Provider.of<FacebookSignINController>(context, listen: false)
             .facebookLogin(context: context);
            //Navigator.pushNamedAndRemoveUntil(
                //context, FacebookLogin.routeName, (route) => false);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: kPrimaryColor,
              ),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset("assets/icons/facebook.svg",
                height: 20, width: 20, color: kPrimaryColor),
          ),
        ),
        /*GestureDetector(
          onTap: () {
           // Navigator.pushNamedAndRemoveUntil(
             //   context, GoogleLogin.routeName, (route) => false);
            Provider.of<GoogleSignINController>(context, listen: false)
                .googleLogin(context: context);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: kPrimaryColor,
              ),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset("assets/icons/google-plus.svg",
                height: 20, width: 20, color: kPrimaryColor),
          ),
        ),*/
      ],
    );
  }


  loginUIGoogle() {
    return Consumer<GoogleSignINController>(builder: (context, model, child) {
      if (model.user != null) {
        return Center(
          child: loggedInUIGoogle(model, context),
        );
      } else {
        //return Text("null");
        //return loginControls(context);
        return loginControlsGoogle();
      }
    });
  }

  loggedInUIGoogle(GoogleSignINController model, BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: Image.network(model.user!.image ?? '').image,
              radius: 50,
            ),
            Text(model.user!.firstName),
            Text(model.user!.email),
            ActionChip(
                avatar: Icon(Icons.logout),
                label: Text("Logout"),
                onPressed: () {
                  Provider.of<GoogleSignINController>(context, listen: false)
                      .logout();
                }),
          ]),
    );
  }

  loginControlsGoogle() {
    return /*Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Provider.of<GoogleSignINController>(context, listen: false)
                .facebookLogin(context: context);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: kPrimaryColor,
              ),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset("assets/icons/facebook.svg",
                height: 20, width: 20, color: kPrimaryColor),
          ),
        ),*/
        GestureDetector(
          onTap: () {
            Provider.of<GoogleSignINController>(context, listen: false)
                .googleLogin(context: context);
            
            
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: kPrimaryColor,
              ),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset("assets/icons/google-plus.svg",
                height: 20, width: 20, color: kPrimaryColor),
          ),
        //),
     // ],
    );
  }
}
