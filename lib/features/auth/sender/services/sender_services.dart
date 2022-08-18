import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:gocolis/constants/error_handling.dart';
import 'package:gocolis/constants/global_variables.dart';
import 'package:gocolis/constants/utils.dart';
import 'package:gocolis/features/auth/sender/screens/sender_home.dart';
import 'package:gocolis/models/user.dart';
import 'package:gocolis/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../models/delivery_request_model.dart';

class SenderServices {
  void addDeliveryRequest({
    required BuildContext context,
    required String title,
    required String description,
    required String addressFrom,
    required String addressTo,
    required String whishedDate,
    required String size,
    required double price,
    required List<File> images,
    String? senderId,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('djpipw8hs', 'acpte2we');
      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: title),
        );
        imageUrls.add(res.secureUrl);
      }

      DeliveryRequest deliveryRequest = DeliveryRequest(
        title: title,
        description: description,
        addressFrom: addressFrom,
        addressTo: addressTo,
        whishedDate: whishedDate,
        price: price,
        size: size,
        images: imageUrls,
        senderId: userProvider.user.id,
      );

      http.Response res = await http.post(
        Uri.parse(
          '$uri/api/sender/add-delivery-request',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: deliveryRequest.toJson(),
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            onSuccess() {
              showSnackBar(context, 'Delivery Request Added Successfully ! ');
              Navigator.pop(context);
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // GET ALL DELIVERIES
  Future<List<DeliveryRequest>> fetchAllDeliveries(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<DeliveryRequest> deliveriesList = [];
    try {
      http.Response res = await http.get(
        Uri.parse(
          '$uri/api/sender/get-delivery-request',
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
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              deliveriesList.add(
                DeliveryRequest.fromJson(jsonEncode(jsonDecode(res.body)[i])),
              );
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return deliveriesList;
  }

  // DELETE DELIVERY REQUEST
  void deleteDeliveryRequest({
    required BuildContext context,
    required DeliveryRequest deliveryRequest,
    // to update the page => real time + set State !!
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse(
          '$uri/api/sender/delete-delivery-request',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': deliveryRequest.id,
        }),
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            onSuccess();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // UPDATE DELIVERY REQUEST
  void updateDeliveryRequest({
    required BuildContext context,
    required DeliveryRequest deliveryRequest,
    required String title,
    required String description,
    required String addressFrom,
    required String addressTo,
    required String whishedDate,
    required String size,
    required double price,
    //required List<File> images,
    String? senderId,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse(
          '$uri/api/sender/update-delivery-request',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': deliveryRequest.id,
          'title': title,
          'description': description,
          'addressFrom': addressFrom,
          'addressTo': addressTo,
          'whishedDate': whishedDate,
          'price': price,
          'size': size,
          //'images': images,
        }),
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            onSuccess();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

//------------------------------------------------------------------------------------------------------------------------------------------------
// SOCIAL LOGIN
  static var client = http.Client();

  Future<bool> sociaLLLogin(String email) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json,'};

    var response = await client.post(Uri.parse('$uri/api/auth/socialLogin'),
        headers: requestHeaders,
        body: {
          "email": email,
        });

    if (response.statusCode == 200) {
      print(response.body);
      return true;
    } else {
      return false;
    }
  }

// SIGN UP USER ---------------------------------------------------------------------------------------------------------------------------
  void socialRegister({
    required BuildContext context,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String birthDate,
    required String? phoneNumber,
    String? image,
    String? userType = "sender",
    String? authType = "fb&gmail",
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      User user = User(
          authType: 'fb&gmail',
          birthDate: "fb&gmail",
          id: '',
          email: email,
          firstName: firstName,
          lastName: "fb&gmail",
          password: "fb&&gmail",
          token: '',
          userType: 'sender',
          phoneNumber: '',
          image: '',);

      http.Response res = await http.post(
          Uri.parse('$uri/api/auth/socialRegister'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,

          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Account created!');
            Navigator.pushNamedAndRemoveUntil(
                context, SenderHome.routeName, (route) => false);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

// SIGN IN USER ---------------------------------------------------------------------------------------------------------------------------
  /*void socialLogin({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
          Uri.parse('$uri/api/auth/socialLogin'),
          body: jsonEncode({
            'email': email,
            'password': "fb&&gmail",
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            Navigator.pushNamedAndRemoveUntil(
                context, SenderHome.routeName, (route) => false);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }*/

  /*void social({
    required BuildContext context,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String birthDate,
    required String? phoneNumber,
    String? userType = "sender",
    String? authType = "fb&gmail",
  }) async {
    try {

      if(!user) {

      }

      User user = User(
          authType: 'fb&gmail',
          birthDate: "fb&gmail",
          id: '',
          email: email,
          firstName: firstName,
          lastName: "fb&gmail",
          password: "fb&&gmail",
          token: '',
          userType: 'sender');

      http.Response res = await http.post(
          Uri.parse('$uri/api/auth/socialLogin'),
          body: jsonEncode({
            'email': email,
            'password': "fb&&gmail",
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            Navigator.pushNamedAndRemoveUntil(
                context, SenderHome.routeName, (route) => false);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }*/
}


/*// UPDATE DELIVERY REQUEST
  void updateDeliveryRequest({
    required BuildContext context,
    required DeliveryRequest deliveryRequest,
    required String title,
    required String description,
    required String addressFrom,
    required String addressTo,
    required String whishedDate,
    required String size,
    required double price,
    required List<File> images,
    String? senderId,
    //required DeliveryRequest deliveryRequest,
    // to update the page => real time + set State !!
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('djpipw8hs', 'acpte2we');
      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: title),
        );
        imageUrls.add(res.secureUrl);
      }

      DeliveryRequest UpdateDeliveryRequest = DeliveryRequest(
        title: title,
        description: description,
        addressFrom: addressFrom,
        addressTo: addressTo,
        whishedDate: whishedDate,
        price: price,
        size: size,
        images: imageUrls,
        senderId: userProvider.user.id,
      );
      http.Response res = await http.post(
        Uri.parse(
          '$uri/api/sender/update-delivery-request',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': deliveryRequest.id,
        }),
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            onSuccess();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }*/