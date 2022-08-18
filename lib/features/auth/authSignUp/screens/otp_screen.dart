import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:gocolis/common/widgets/custom_button.dart';
import 'package:gocolis/constants/colors.dart';
import 'package:gocolis/features/auth/authSignUp/screens/otp_verify_page.dart';
import 'package:gocolis/features/auth/authSignUp/services/authService.dart';

class OTPScreen extends StatefulWidget {
  static const routeName = '/otp-screen';
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String birthDate;

  const OTPScreen(
      {Key? key,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      required this.birthDate})
      : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _otpFormKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();
  Country? country;
  final AuthService authService = AuthService();

  String phoneNumber = '';
  bool isAPICallProcess = false;

  @override
  void dispose() {
    super.dispose();
    _phoneNumberController.dispose();
  }


  void pickCountry() {
    showCountryPicker(
        context: context,
        onSelect: (Country _country) {
          setState(() {
            country = _country;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Enter your phone number"),
        elevation: 0,
        backgroundColor: kPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: _otpFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                TextButton(
                  onPressed: pickCountry,
                  child: const Text('Pick Country'),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    if (country != null) Text('+${country!.phoneCode}'),
                    const SizedBox(width: 10),
                    SizedBox(
                        width: size.width * 0.7,
                        child: TextField(
                            controller: _phoneNumberController,
                            decoration: const InputDecoration(
                              hintText: 'phone Number',
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (String value) {
                              phoneNumber = value;
                            })),
                  ],
                ),
                SizedBox(
                  width: size.width * 0.6,
                ),
                SizedBox(
                  width: size.width * 0.6,
                  child: CustomButton(
                    onPressed: () {
                      if (_otpFormKey.currentState!.validate()) {
                        if (phoneNumber.length > 7) {
                          setState(() {
                            isAPICallProcess = true;
                          });
                          AuthService.CreateOtp(phoneNumber).then(
                            (response) async {
                              setState(() {
                                isAPICallProcess = false;
                              });
                              print(widget.firstName);
                              print(response.message);
                              print(response.data);
                              if (response.data != null) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OtpVerifyScreen(
                                      otpHash: response.data,
                                      phoneNumber: phoneNumber,
                                      firstName: widget.firstName,
                                      lastName: widget.lastName,
                                      email:  widget.email,
                                      password: widget.password,
                                      birthDate: widget.birthDate,
                                    ),
                                  ),
                                  (route) => false,
                                );
                              }
                            },
                          );
                        }
                      }
                    },
                    boxColor: kPrimaryColor,
                    text: 'NEXT',
                    textColor: kPrimaryLightColor,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      key: UniqueKey(),
    ));
  }
}
