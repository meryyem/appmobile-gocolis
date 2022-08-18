import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gocolis/constants/colors.dart';
import 'package:gocolis/constants/global_variables.dart';
import 'package:gocolis/constants/utils.dart';
import 'package:gocolis/features/home/screens/home_screen.dart';
import 'package:gocolis/features/profile/services/profile_services.dart';
import 'package:image_picker/image_picker.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({Key? key}) : super(key: key);

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  //here i will save the image
  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final _globalKey = GlobalKey<FormState>();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _birthDate = TextEditingController();

  bool circular = false;

  // create an instance from network handler class
  final ProfileServices _profileServices = ProfileServices();

  void AddProfile() {
    if (_globalKey.currentState!.validate() && _imageFile != null) {
      _profileServices.addProfile(
        context: context,
        firstName: _firstName.text,
        lastName: _lastName.text,
        email: _email.text,
        birthDate: _birthDate.text,
        phoneNumber: _phoneNumber.text,
        image: _imageFile!.path,
        onSuccess: () {
            //setState(() {});
            showSnackBar(context, 'Profile Added Successfully ! ');
            Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                          (route) => false);
            //Navigator.pushNamed(context, PostsScreen.routeName);
          },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            imageProfile(),
            const SizedBox(height: 10),
            firstNameTextField(),
            const SizedBox(height: 5),
            lastNameTextField(),
            const SizedBox(height: 10),
            emailTextField(),
            const SizedBox(height: 5),
            phoneNumberTextField(),
            const SizedBox(height: 10),
            birthDateTextField(),
            const SizedBox(height: 5),
            InkWell(
              onTap: () async {
                setState(() {
                  circular = true;
                });
                if (_globalKey.currentState!.validate()) {
                  /* Map<String, String> data = {
                    "firstName": _firstName.text,
                    "lastName": _lastName.text,
                    "email": _email.text,
                    "phoneNumber": _phoneNumber.text,
                    "birthDate": _birthDate.text,
                  };*/

                  /*print(response.statusCode);
                  if (response.statusCode == 200 ||
                      response.statusCode == 201) {*/

                  if (_imageFile != null) {
                    var imageResponse = await _profileServices.patchImage(
                        context, "$uri/api/addImage", _imageFile!.path);

                    /*var response = await _profileServices.post(
                        firstName: _firstName.text,
                        lastName: _lastName.text,
                        email: _email.text,
                        context: context,
                        birthDate: _birthDate.text,
                        phoneNumber: _phoneNumber.text,
                        image: _imageFile!.path,
                      );*/

                    //var response = await _profileServices.AddProfile();

                    /*if (imageResponse.statusCode == 200 ||
                        response.statusCode == 200 ||
                        response.statusCode == 201) {
                      setState(() {
                        circular = false;
                      });
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                          (route) => false);
                    }*/
                  } /*else {
                      setState(() {
                        circular = false;
                      });
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                          (route) => false);
                    }*/
                }
                //}
              },
              child: Center(
                child: Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(10)),
                  child: circular
                      ? const CircularProgressIndicator()
                      : InkWell(
                        child: const Text("Submit"),
                        onTap: AddProfile,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget firstNameTextField() {
    return TextFormField(
        controller: _firstName,
        validator: (value) {
          if (value!.isEmpty) return "FirstName can't be empty.";
          return null;
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.teal,
          )),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.orange,
          )),
          prefixIcon: Icon(
            Icons.person,
            color: Colors.green,
          ),
          labelText: "Name",
          helperText: "John",
          hintText: "John",
        ));
  }

  Widget lastNameTextField() {
    return TextFormField(
        controller: _lastName,
        validator: (value) {
          if (value!.isEmpty) return "FirstName can't be empty.";
          return null;
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.teal,
          )),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.orange,
          )),
          prefixIcon: Icon(
            Icons.person,
            color: Colors.green,
          ),
          labelText: "Name",
          helperText: "John",
          hintText: "John",
        ));
  }

  Widget emailTextField() {
    return TextFormField(
        controller: _email,
        validator: (value) {
          if (value!.isEmpty) return "FirstName can't be empty.";
          return null;
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.teal,
          )),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.orange,
          )),
          prefixIcon: Icon(
            Icons.person,
            color: Colors.green,
          ),
          labelText: "Name",
          helperText: "John",
          hintText: "John",
        ));
  }

  Widget phoneNumberTextField() {
    return TextFormField(
        controller: _phoneNumber,
        validator: (value) {
          if (value!.isEmpty) return "FirstName can't be empty.";
          return null;
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.teal,
          )),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.orange,
          )),
          prefixIcon: Icon(
            Icons.person,
            color: Colors.green,
          ),
          labelText: "Name",
          helperText: "John",
          hintText: "John",
        ));
  }

  Widget birthDateTextField() {
    return TextFormField(
        controller: _birthDate,
        validator: (value) {
          if (value!.isEmpty) return "FirstName can't be empty.";
          return null;
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.teal,
          )),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.orange,
          )),
          prefixIcon: Icon(
            Icons.person,
            color: Colors.green,
          ),
          labelText: "Name",
          helperText: "John",
          hintText: "John",
        ));
  }

  Widget imageProfile() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 80.0,
            backgroundImage:
                _imageFile == null ? null : FileImage(File(_imageFile!.path)),
            //_imageFile == null ? File(AssetImage('assets/images/bg.png').toString()): Image.file(_imageFile, height: 100, width: 100),
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context, builder: ((builder) => bottomSheet()));
              },
              child: const Icon(
                Icons.camera_alt,
                color: kPrimaryLightColor,
                size: 20.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          const Text("Choose Profile Photo From"),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                label: const Text('Camera'),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                icon: const Icon(Icons.camera),
              ),
              const SizedBox(width: 20.0),
              ElevatedButton.icon(
                label: const Text('Gallery'),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                icon: const Icon(Icons.image),
              ),
            ],
          )
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile!;
    });
  }
}
