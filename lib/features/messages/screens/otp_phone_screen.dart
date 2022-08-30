import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gocolis/constants/colors.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class OTPphoneScreen extends StatefulWidget {
  final String number;
  final String countryCode;
  const OTPphoneScreen(
      {Key? key, required this.number, required this.countryCode})
      : super(key: key);

  @override
  State<OTPphoneScreen> createState() => _OTPphoneScreenState();
}

class _OTPphoneScreenState extends State<OTPphoneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Verify + ${widget.countryCode} ${widget.number}",
          style: const TextStyle(
            color: kPrimaryLightColor,
            fontSize: 16.5,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "We have sent an SMS with a code to",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.5,
                    ),
                  ),
                  TextSpan(
                    text: "+" + widget.countryCode + " " + widget.number,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(
                    text: "Wrong Number ?",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 14.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            OTPTextField(
              length: 6,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 58,
              otpFieldStyle: OtpFieldStyle(
                backgroundColor: Color(0xff1d1d1d),
                borderColor: Colors.white,
              ),
              style: const TextStyle(
                fontSize: 17,
                color: Colors.white,
              ),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.underline,
              onCompleted: (pin) {
                print("Completed: " + pin);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Enter 6-digit code",
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 14.5,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            bottomButton("Resend SMS", Icons.message),
            const SizedBox(
              height: 12,
            ),
            const Divider(
              thickness: 1.5,
            ),
            const SizedBox(
              height: 12,
            ),
            bottomButton("Call Me", Icons.call),
            
          ],
        ),
      ),
    );
  }

  Widget bottomButton(String text, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: kPrimaryColor,
          size: 24,
        ),
        const SizedBox(
          height: 25,
        ),
        Text(
          text,
          style: const TextStyle(
            color: kPrimaryColor,
            fontSize: 14.5,
          ),
        ),
      ],
    );
  }
}
