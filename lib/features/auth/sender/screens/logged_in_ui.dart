/*import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gocolis/constants/colors.dart';
import 'package:gocolis/features/auth/sender/services/facebook_login_controller.dart';
import 'package:gocolis/features/auth/sender/services/google_login_controller.dart';
import 'package:gocolis/features/auth/sender/services/social_login_controller.dart';
import 'package:provider/provider.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loginUI(),
    );
  }

  loginUI() {
    return Consumer<SocialLoginController>(builder: (context, model, child) {
      if (model.user != null) {
        return Center(
          child: loggedInUI(model, context),
        );
      } else {
        //return Text("null");
        return loginControls(context);
      }
    });
  }

  loggedInUI(SocialLoginController model, BuildContext context) {
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

  //login images here => facebook and google //to add in the orDivider part !!
  loginControls(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Provider.of<FacebookSignINController>(context, listen: false)
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
            Provider.of<SocialLoginController>(context, listen: false)
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
        ),
      ],
    );
  }
}
*/