import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/restaurant_result.dart';

class ApiService {
  static final String _authority = 'restaurant-api.dicoding.dev';
  static final String _pathListRestaurant = '/list';

  Future<RestaurantResult> getRestaurant() async {
    final Uri url = Uri.https(_authority, _pathListRestaurant);

    final response = await http.get(url);
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception("Gagal mengambil data restaurant");
    }
  }
}
