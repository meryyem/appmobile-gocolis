// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RideRequest {
  final String title;
  final String addressFrom;
  final String addressTo;
  final String whishedDate;
  final double price;
  final String? id;
  final String? travelerId;

  RideRequest({required this.title, required this.addressFrom, required this.addressTo, required this.whishedDate, required this.price, required this.id, this.travelerId});

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'addressFrom': addressFrom,
      'addressTo': addressTo,
      'whishedDate': whishedDate,
      'price': price,
      'id': id,
      'travelerId': travelerId,
    };
  }

  factory RideRequest.fromMap(Map<String, dynamic> map) {
    return RideRequest(
      title: map['title'] as String,
      addressFrom: map['addressFrom'] as String,
      addressTo: map['addressTo'] as String,
      whishedDate: map['whishedDate'] as String,
      price: map['price']?.toDouble() ?? 0.0,
      id: map['id'] != null ? map['id'] as String : null,
      travelerId: map['travelerId'] != null ? map['travelerId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RideRequest.fromJson(String source) => RideRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
