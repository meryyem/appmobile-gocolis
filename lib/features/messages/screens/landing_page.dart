import 'package:flutter/material.dart';
import 'package:gocolis/constants/colors.dart';
import 'package:gocolis/features/messages/screens/login_page.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 50),
              const Text(
                "Welcome to GOCOLIS",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 29,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 8),
              Image.asset("assets/images/bg.png",
                  color: kPrimaryLightColor, height: 340, width: 340),
              SizedBox(height: MediaQuery.of(context).size.height / 7.5),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                      children: [
                        TextSpan(
                          text: "Agree and Continue to accept the",
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                        const TextSpan(
                          text: "Chat Terms of Service and privacy Policy",
                          style: TextStyle(
                            color: Colors.cyan,
                          ),
                        ),
                      ]),
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (builder) => ChatLoginPage()), (route) => false
                  );
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 110,
                  child: const Card(
                    margin: EdgeInsets.all(0),
                    elevation: 8,
                    color: kPrimaryLightColor,
                    child: Center(
                      child: Text(
                        "AGREE AND CONTINUE",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
