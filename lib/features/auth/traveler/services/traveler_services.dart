import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gocolis/constants/error_handling.dart';
import 'package:gocolis/constants/global_variables.dart';
import 'package:gocolis/constants/utils.dart';
import 'package:gocolis/models/ride_request.dart';
import 'package:gocolis/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class TravelerServices {
  void addRideRequest({
    required BuildContext context,
    required String title,
    required String addressFrom,
    required String addressTo,
    required String whishedDate,
    required double price,
    String? travelerId,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      RideRequest rideRequest = RideRequest(
        id: '',
        title: title,
        addressFrom: addressFrom,
        addressTo: addressTo,
        whishedDate: whishedDate,
        price: price,
        travelerId: userProvider.user.id,
      );

      http.Response res = await http.post(
        Uri.parse(
          '$uri/api/traveler/add-ride-request',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: rideRequest.toJson(),
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            onSuccess() {
              showSnackBar(context, 'Ride Request Added Successfully ! ');
              Navigator.pop(context);
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // GET ALL DELIVERIES
  Future<List<RideRequest>> fetchAllRides(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<RideRequest> ridesList = [];
    try {
      http.Response res = await http.get(
        Uri.parse(
          '$uri/api/traveler/get-ride-request',
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
              ridesList.add(
                RideRequest.fromJson(jsonEncode(jsonDecode(res.body)[i])),
              );
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return ridesList;
  }

  // DELETE RIDE REQUEST
  void deleteRideRequest({
    required BuildContext context,
    required RideRequest rideRequest,
    // to update the page => real time + set State !!
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse(
          '$uri/api/traveler/delete-ride-request',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': rideRequest.id,
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

  // UPDATE RIDE REQUEST
  void updateRideRequest({
    required BuildContext context,
    required RideRequest rideRequest,
    required String title,
    required String addressFrom,
    required String addressTo,
    required String whishedDate,
    required double price,
    //required List<File> images,
    String? travelerId,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse(
          '$uri/api/traveler/update-ride-request',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': rideRequest.id,
          'title': title,
          'addressFrom': addressFrom,
          'addressTo': addressTo,
          'whishedDate': whishedDate,
          'price': price,
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
}
