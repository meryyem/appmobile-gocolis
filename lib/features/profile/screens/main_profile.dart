import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gocolis/features/profile/services/profile_services.dart';
import 'package:gocolis/models/profile.dart';

class MainProfile extends StatefulWidget {
  const MainProfile({Key? key}) : super(key: key);

  @override
  State<MainProfile> createState() => _MainProfileState();
}

class _MainProfileState extends State<MainProfile> {
  bool circular = true;
  final ProfileServices _profileServices = ProfileServices();
  Profile profileModel = Profile(
      firstName: '',
      lastName: '',
      email: '',
      birthDate: '',
      phoneNumber: '',
      image: '');

  //Profile? profileModel;

  @override
  void initState() {
    super.initState();
    fetchData();
    //fetchData(profileModel);
  }

  /*fetchData() async {
    var profile = await _profileServices.fetchProfile(context);
    setState(() {
      profileModel = Profile.fromJson(json.encode(profile));
    });
  }*/

  /*void fetchData(Profile profile) {
    _profileServices.profile(
        context: context,
        profile: profile,
        onSuccess: () {
          setState(() {
            profileModel =
                Profile.fromJson(jsonEncode(jsonDecode(profile.toString())));
            circular = false;
            // profileModel = Profile.fromJson(json.encode(profile));
            // profileModel = Profile.fromJson(jsonEncode(jsonDecode(profile.toString())));
          });
        });
  }*/

  void fetchData() async {
    var response = await _profileServices.get(context);
    setState(() {
      profileModel = Profile.fromJson(json.encode(response['data']));
      circular = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white10,
        /*leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
          color: Colors.black,
        ),*/
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {},
            color: Colors.black,
          ),
        ],
      ),
      body: circular
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                head(),
                const Divider(
                  thickness: 0.8,
                ),
                otherDetails("EMAIL", profileModel.email),
                const Divider(
                  thickness: 0.8,
                ),
                otherDetails("PHONENUMBER", profileModel.phoneNumber!),
                otherDetails("BIRTHDATE", profileModel.birthDate),
              ],
            ),
    );
  }

  Widget head() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(
          child: CircleAvatar(
            radius: 50,
            backgroundImage: ProfileServices().getProfileImage("undefined"),
          ),
        ),
        const Text("Maryem",
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        const Text("Title",
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
      ]),
    );
  }

  Widget otherDetails(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$label : ",
              style:
                  const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text(value,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
