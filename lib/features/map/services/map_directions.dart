// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:gocolis/constants/.env.dart';
import 'package:gocolis/models/map_directions.dart';

class MapDirections {
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';

  Dio? dio;
  
  MapDirections({
    this.dio,
  });


  // GET DIRECTIONS
  Future<Directions?> getDirections({
    required LatLng origin,
    //required LatLng destination,
  }) async {
    final response = await dio!.get(_baseUrl, queryParameters: {
      'origin': '${origin.latitude},${origin.longitude}',
      //'destination': '${destination.latitude},${destination.longitude}',
      'key': googleAPIKey,
    });
    //check if response is successful
    if (response.statusCode == 200) {
      return Directions.fromMap(response.data);
    }
    return null;
  }
}
