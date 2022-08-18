import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gocolis/constants/error_handling.dart';
import 'package:gocolis/constants/global_variables.dart';
import 'package:gocolis/constants/utils.dart';
import 'package:gocolis/models/profile.dart';
import 'package:gocolis/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class ProfileServices {
  String baseUrl = uri;
  var log = Logger();

  Future get(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    var response = await http.get(
      Uri.parse('$uri/api/profileData'),
      headers: {
        "content-type": "application/json",
        'x-auth-token': userProvider.user.token,
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      log.i(response.body);
      return json.decode(response.body);
    }

    log.i(response.body);
    log.i(response.statusCode);
  }

  // GET PROFILE
  /*Future<Profile> fetchProfile(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Profile profile = Profile(
        firstName: '',
        lastName: '',
        email: '',
        birthDate: '',
        phoneNumber: '',
        image: '');
    try {
      http.Response res = await http.get(
        Uri.parse(
          '$uri/api/profileData',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            profile = Profile.fromJson(jsonEncode(jsonDecode(res.body)));
            log.i(res.body);
            //profile = json.decode(res.body);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return profile;
  }*/

  Future<http.Response> addProfile({
    required BuildContext context,
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String birthDate,
    String? image,
    String? userId,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Profile profile = Profile(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber,
      birthDate: birthDate,
      image: image,
      userId: userProvider.user.id,
    );
    var response = await http.post(
      Uri.parse('$uri/api/addProfile'),
      headers: {
        "content-type": "application/json",
        'x-auth-token': userProvider.user.token,
      },
      body: profile.toJson(),
    );

    httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          onSuccess(); /*{
            showSnackBar(context, 'Profile Added Successfully ! ');
            Navigator.pop(context);
          }*/
        });
    log.d(profile);
    if (response.statusCode == 200 || response.statusCode == 201) {
      //log.i(response.body);
      //return json.decode(response.body);
      return response;
    }

    log.i(response.body);
    log.i(response.statusCode);
    return response;
  }

  Future checkProfile({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    http.Response res = await http.get(
      Uri.parse(
        '$uri/api/checkProfile',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      },);
    /*httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            
            //Profile.fromJson(jsonEncode(jsonDecode(res.body)));
            //Profile.fromJson(jsonDecode(res.body));
          });*/

    if (res.statusCode == 200 || res.statusCode == 201) {
      log.i(res.body);
      return json.decode(res.body);
    }
    log.i(res.body);
    log.i(res.statusCode);
    return json.decode(res.body);
  }

  Future<http.StreamedResponse> patchImage(
      BuildContext context, String url, String filePath) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    //url = baseUrl + url;
    var request = http.MultipartRequest('PATCH', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath("img", filePath));
    request.headers.addAll({
      "Content-type": "multipart/form-data",
      'x-auth-token': userProvider.user.token,
    });
    var response = request.send();
    return response;
  }

  NetworkImage getProfileImage(String email) {
    String url = "$uri/uploads//$email.jpg";
    return NetworkImage(url);
  }

  // GET PROFILE
  Future<Profile> profile({
    required BuildContext context,
    required Profile profile,
    // to update the page => real time + set State !!
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse(
          '$uri/api/profileData',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'email': profile.email,
        }),
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            onSuccess();
            log.i(res.body);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return profile;
  }
}
