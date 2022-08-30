import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gocolis/constants/colors.dart';
import 'package:gocolis/features/messages/screens/country_page.dart';
import 'package:gocolis/features/messages/screens/otp_phone_screen.dart';
import 'package:gocolis/features/messages/services/phone_service.dart';
import 'package:gocolis/models/country.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class ChatLoginPage extends StatefulWidget {
  const ChatLoginPage({Key? key}) : super(key: key);

  @override
  State<ChatLoginPage> createState() => _ChatLoginPageState();
}

class _ChatLoginPageState extends State<ChatLoginPage> {
  String countryName = "Tunisia";
  String countryCode = "+216";
  TextEditingController _phoneController = TextEditingController();
  int start = 60;
  bool wait = false;
  String buttonName = "Send";
  // create an object of the auth class
  PhoneService phoneService = PhoneService();
  // a verifictaion id variable which is required at the time of the signing !!!!!
  String verificationIDFinal = "";
  String smsCode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Enter your phone Number",
          style: TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.w700,
            wordSpacing: 1,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: const [
          Icon(
            Icons.more_vert,
            color: Colors.black,
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const Text(
              "GOCOLIS will send an sms message to verify your number",
              style: TextStyle(
                fontSize: 13.5,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "What's my number",
              style: TextStyle(
                fontSize: 12.8,
                color: kPrimaryLightColor,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            countryCard(),
            const SizedBox(
              height: 5,
            ),
            number(),
            Expanded(
              child: Container(),
            ),
            InkWell(
              onTap: () {
                if (_phoneController.text.length < 10) {
                  noPhoneDialog();
                } else {
                  showPhoneDialog();
                }
              },
              child: Container(
                height: 40,
                width: 70,
                color: kPrimaryLightColor,
                child: const Center(
                  child: Text(
                    "NEXT",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            textField(),
            const SizedBox(height: 10),
            OTPTextField(
              length: 6,
              width: MediaQuery.of(context).size.width - 40,
              fieldWidth: 60,
              otpFieldStyle: OtpFieldStyle(
                backgroundColor: Colors.grey,
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
                setState(() {
                  smsCode = pin;
                });
              },
            ),
            const SizedBox(height: 10),
            // ----------------------------------------------------------------------------------------------------------------------

            // --------------------------------------------------------------------- put the otp in the same page -------------------------------
            /*Expanded(
              child: Container(
                height: 1,
                color: Colors.grey,
                margin: const EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
            const Text(
              "Enter 6 digit OTP",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            Expanded(
              child: Container(
                height: 1,
                color: Colors.grey,
                margin: const EdgeInsets.symmetric(horizontal: 12),
              ),
            ),*/
            // ----------------------------------------------------------------------------------------------------------------------------------
            Column(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Send OTP again in",
                        style:
                            TextStyle(fontSize: 16, color: Colors.amberAccent),
                      ),
                      TextSpan(
                        text: "00:$start ",
                        style: const TextStyle(
                            fontSize: 16, color: Colors.amberAccent),
                      ),
                      const TextSpan(
                        text: "sec",
                        style:
                            TextStyle(fontSize: 16, color: Colors.amberAccent),
                      ),
                    ],
                  ),
                ),
                // ---------------------------------------------------------------another button --------------------------------------------
                const SizedBox(height: 100),
                InkWell(
                  onTap: () {
                    phoneService.signInWithPhoneNumber(
                        verificationIDFinal, smsCode, context, (){}, (){});
                  },
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width - 60,
                    decoration: BoxDecoration(
                      color: Color(0xffff9601),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Center(
                      child: Text(
                        //when i click on this let's go button the verification id variable will be required !!
                        "Let's Go",
                        style: TextStyle(
                          fontSize: 17,
                          color: Color(0xfffbe2ae),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget countryCard() {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (builder) =>
                      CountryPage(setCountryData: setCountryData)));
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 1.5,
          padding: const EdgeInsets.symmetric(vertical: 5),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.black,
                width: 1.8,
              ),
            ),
          ),
          child: Row(children: [
            Expanded(
              child: Container(
                child: Center(
                  child: Text(
                    countryName,
                    style: const TextStyle(
                      fontSize: 16,
                      color: kPrimaryLightColor,
                    ),
                  ),
                ),
              ),
            ),
            const Icon(Icons.arrow_drop_down, color: kPrimaryColor),
          ]),
        ));
  }

  Widget number() {
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      height: 38,
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Container(
            width: 70,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 1.8,
                ),
              ),
            ),
            child: Row(children: [
              const SizedBox(
                width: 10,
              ),
              const Text(
                "+",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                countryCode.substring(1),
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ]),
          ),
          const SizedBox(
            width: 30,
          ),
          /*Container(
            width: MediaQuery.of(context).size.width / 1.5 - 100,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 1.8,
                ),
              ),
            ),
            child: TextFormField(
                //controller: _phoneController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 19, horizontal: 8),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 15),
                    child: Text(
                      " + 216 ",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                  suffixIcon: InkWell(
                    onTap: wait
                        ? null
                        : () {
                            setTimer();
                            setState(() {
                              //after 30 s the timer will be 0 so to restart it !!
                              start = 60;
                              wait = true;
                              buttonName = "Resend";
                            });
                          },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 15),
                      child: Text(
                        buttonName,
                        style: TextStyle(
                          color: wait ? Colors.grey : Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  hintText: "Enter your Phone number",
                  hintStyle: const TextStyle(color: Colors.white, fontSize: 17),
                )),
          ),*/
        ],
      ),
    );
  }

  void setCountryData(Country country) {
    setState(() {
      countryName = country.name;
      countryCode = country.code;
    });
    Navigator.pop(context);
  }

  Future<void> showPhoneDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("We will be veryfying your phone number",
                        style: TextStyle(
                          fontSize: 14,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(countryCode + " " + _phoneController.text,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                        "Is this OK, or would you like to edit your number",
                        style: TextStyle(
                          fontSize: 13.5,
                        )),
                  ],
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Edit")),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => OTPphoneScreen(
                                    countryCode: countryCode,
                                    number: _phoneController.text,
                                  )));
                    },
                    child: const Text("OK")),
              ]);
        });
  }

  Future<void> noPhoneDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("There is no phone number",
                        style: TextStyle(
                          fontSize: 14,
                        )),
                  ],
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("OK")),
              ]);
        });
  }

  void setTimer() {
    const onsec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          //after 30 s wait value should be false !!
          wait = false;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  Widget textField() {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: 60,
      decoration: BoxDecoration(
        color: Color(0xff1d1d1d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _phoneController,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Enter Your Phone Number",
          hintStyle: TextStyle(color: Colors.white54, fontSize: 17),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 19, horizontal: 8),
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 15),
            child: Text(
              " + 216 ",
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
          suffixIcon: InkWell(
            onTap: wait
                ? null
                : () async {
                    //setTimer();
                    setState(() {
                      //after 30 s the timer will be 0 so to restart it !!
                      start = 60;
                      wait = true;
                      buttonName = "Resend";
                    });
                    await phoneService.verifyPhoneNumber(
                        " + 216 ${_phoneController.text}", context, setData);
                  },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Text(
                buttonName,
                style: TextStyle(
                  color: wait ? Colors.grey : Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // i need a verification id but in the phone service there is no way
  //to get a verification id so i will create this method
  // iam getting a verificationId from the phone service to the phone and i have the 
  // same name of the local variable so i have to change the local variablke to store the verificationId 
  void setData(String verificationID) {
    setState(() {
      verificationIDFinal = verificationID;
    });
    //call the timer when we get the code
    setTimer();
  }
}
