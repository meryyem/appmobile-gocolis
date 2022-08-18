import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/widgets.dart';
import 'package:gocolis/constants/error_handling.dart';
import 'package:gocolis/constants/utils.dart';
import 'package:gocolis/models/delivery_request_model.dart';
import 'package:gocolis/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../../constants/global_variables.dart';

class AdminServices {
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
}
