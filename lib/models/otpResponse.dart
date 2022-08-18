import 'dart:convert';

OTPResponse oTPResponseJSON(String str) =>
    OTPResponse.fromJson(json.decode(str));

class OTPResponse {
  late final String? message;
  late final String? data;

  OTPResponse({
    required this.message,
    required this.data,
  });

  OTPResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'];
  }
}
