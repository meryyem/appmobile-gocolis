import 'dart:convert';

class DeliveryRequest {
  final String title;
  final String description;
  final String addressFrom;
  final String addressTo;
  final String whishedDate;
  final String size;
  final double price;
  final List<String> images;
  final String? id;
  final String? senderId;

  DeliveryRequest(
      {required this.title,
      required this.description,
      required this.addressFrom,
      required this.addressTo,
      required this.whishedDate,
      required this.size,
      required this.price,
      required this.images,
      this.id,
      this.senderId});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'addressFrom': addressFrom,
      'addressTo': addressTo,
      'whishedDate': whishedDate,
      'size': size,
      'price': price,
      'images': images,
      'id': id,
      'senderId': senderId,
    };
  }

  factory DeliveryRequest.fromMap(Map<String, dynamic> map) {
    return DeliveryRequest(
      title: map['title'] as String,
      description: map['description'] as String,
      addressFrom: map['addressFrom'] as String,
      addressTo: map['addressTo'] as String,
      whishedDate: map['whishedDate'] as String,
      size: map['size'] as String,
      price: map['price']?.toDouble() ?? 0.0,
      images: List<String>.from(map['images']),
      id: map['_id'] as String,
      senderId: map['senderId']as String,
      //id: map['_id'] != null ? map['_id'] as String : null,
      //senderId: map['senderId'] != null ? map['senderId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeliveryRequest.fromJson(String source) =>
      DeliveryRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
