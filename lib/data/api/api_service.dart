import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/detail_restaurant_result.dart';
import 'package:restaurant_app/data/model/restaurant_result.dart';

class ApiService {
  static final String _authority = 'restaurant-api.dicoding.dev';
  static final String _pathListRestaurant = '/list';
  static final String _pathDetailRestaurant = '/detail';

  Future<RestaurantResult> getRestaurant() async {
    final Uri url = Uri.https(_authority, _pathListRestaurant);

    final response = await http.get(url);
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception("Gagal mengambil data restaurant");
    }
  }

  Future<DetailRestaurantResult> getDetailRestaurant(
      String restaurantId) async {
    final Uri url =
        Uri.https(_authority, '$_pathDetailRestaurant/$restaurantId');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      return DetailRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception("Gagal mengambil data restaurant");
    }
  }
}
