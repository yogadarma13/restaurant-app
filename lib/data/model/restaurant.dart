import 'dart:convert';

import 'menu.dart';

class Restaurant {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  String rating;
  Menu menus;

  Restaurant({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
    this.menus,
  });

  Restaurant.fromJson(Map<String, dynamic> restaurant) {
    id = restaurant["id"];
    name = restaurant["name"];
    description = restaurant["description"];
    pictureId = restaurant["pictureId"];
    city = restaurant["city"];
    rating = restaurant["rating"].toString();
    menus = Menu.fromJson(restaurant["menus"]);
  }
}

List<Restaurant> parseRestaurant(String jsonRestaurant) {
  if (jsonRestaurant == null) return [];

  final List parsed = jsonDecode(jsonRestaurant)["restaurants"];
  if (parsed == null) return [];

  return parsed.map((json) => Restaurant.fromJson(json)).toList();
}
