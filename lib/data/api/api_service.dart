import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/detail_restaurant_result.dart';
import 'package:restaurant_app/data/model/restaurant_result.dart';
import 'package:restaurant_app/data/model/review_result.dart';

import '../../main.dart';

class ApiService {
  static final String _authority = 'restaurant-api.dicoding.dev';
  static final String _pathListRestaurant = '/list';
  static final String _pathDetailRestaurant = '/detail';
  static final String _pathSearchRestaurant = "/search";
  static final String _pathReviewRestaurant = "/review";

  http.Client client = http.Client();

  Future<RestaurantResult> getRestaurant() async {
    HttpOverrides.global = MyHttpOverrides();
    final Uri url = Uri.https(_authority, _pathListRestaurant);

    final response = await client.get(url);
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception("Gagal mengambil data restaurant");
    }
  }

  Future<DetailRestaurantResult> getDetailRestaurant(
      String? restaurantId) async {
    HttpOverrides.global = MyHttpOverrides();
    final Uri url =
        Uri.https(_authority, '$_pathDetailRestaurant/$restaurantId');

    final response = await client.get(url);
    if (response.statusCode == 200) {
      return DetailRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception("Gagal mengambil data detail restaurant");
    }
  }

  Future<RestaurantResult> searchRestaurant(String query) async {
    HttpOverrides.global = MyHttpOverrides();
    final Uri url = Uri.https(_authority, _pathSearchRestaurant, {'q': query});

    final response = await client.get(url);
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception("Terjadi kesalahan");
    }
  }

  Future<ReviewResult> addNewReview(
      String restaurantId, String name, String review) async {
    HttpOverrides.global = MyHttpOverrides();
    final Uri url = Uri.https(_authority, _pathReviewRestaurant);

    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json', 'X-Auth-Token': '12345'},
      body: jsonEncode(
        {'id': restaurantId, 'name': name, 'review': review},
      ),
    );
    if (response.statusCode == 200) {
      return ReviewResult.fromJson(json.decode(response.body));
    } else {
      throw Exception("Terjadi kesalahan");
    }
  }
}
