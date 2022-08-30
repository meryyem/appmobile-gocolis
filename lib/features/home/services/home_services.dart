import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gocolis/constants/error_handling.dart';
import 'package:gocolis/constants/global_variables.dart';
import 'package:gocolis/constants/utils.dart';
import 'package:gocolis/models/delivery_request_model.dart';
import 'package:gocolis/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomeServices {
  Future<List<DeliveryRequest>> fetchCategoryDelivery({
    required BuildContext context, 
    required String price}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<DeliveryRequest> deliveriesList = [];
    try {
      http.Response res = await http.get(
        Uri.parse(
          '$uri/api/delivery-request/get-delivery-request',
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
}