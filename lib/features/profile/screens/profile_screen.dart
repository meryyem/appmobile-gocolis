import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gocolis/features/profile/screens/create_profile.dart';
import 'package:gocolis/features/profile/screens/main_profile.dart';
import 'package:gocolis/features/profile/services/profile_services.dart';
import 'package:gocolis/models/profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileServices profileServices = ProfileServices();
  Widget page = const CircularProgressIndicator();

  @override
  void initState() {
    super.initState();
    checkProfile();
  }

  /*bool circular = true;
  Profile profileModel = Profile(
      firstName: '',
      lastName: '',
      email: '',
      birthDate: '',
      phoneNumber: '',
      image: '');*/

  /*void fetchData(Profile profile) {
    profileServices.profile(
        context: context,
        profile: profile,
        onSuccess: () {
          setState(() {
            // profileModel = Profile.fromJson(json.encode(profile));
            // profileModel = Profile.fromJson(jsonEncode(jsonDecode(profile.toString())));
          });
        });
  }*/

  void checkProfile() async {
    var response = await profileServices.checkProfile(
      context: context,
    );
    if (response["status"] == true) {
      setState(() {
        //page = showProfile();
        page: MainProfile();
      });
    } else {
      setState(() {
        page = button();
      });
    }
  }

  Widget showProfile() {
    return Center(child: Text("Profile Data Is Available"));
  }

  /*FetchProfile() async {
    profileModel = await profileServices.profile(
        profile: profileModel,
        context: context,
        onSuccess: () {
          profileModel = Profile.fromJson(profileModel.toJson());
          circular = false;
        });
    setState(() {});
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: page);
    // return Scaffold(body: Center(child: Text(profile.toJson())),);
  }

  Widget button() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 70.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Tap to button to add profile data",
            style: TextStyle(
              color: Colors.deepOrange,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            height: 60,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: InkWell(
              onTap: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateProfile()))
              },
              child: const Center(
                child: Text(
                  "Add Profile",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
