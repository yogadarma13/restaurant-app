import 'customer_review.dart';

class DetailRestaurantResult {
  DetailRestaurantResult({
    this.error,
    this.message,
    this.restaurant,
  });

  bool? error;
  String? message;
  RestaurantDetail? restaurant;

  factory DetailRestaurantResult.fromJson(Map<String, dynamic> json) =>
      DetailRestaurantResult(
        error: json["error"],
        message: json["message"],
        restaurant: RestaurantDetail.fromJson(json["restaurant"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "restaurant": restaurant!.toJson(),
      };
}

class RestaurantDetail {
  RestaurantDetail({
    this.id,
    this.name,
    this.description,
    this.city,
    this.address,
    this.pictureId,
    this.categories,
    this.menus,
    this.rating,
    this.customerReviews,
  });

  String? id;
  String? name;
  String? description;
  String? city;
  String? address;
  String? pictureId;
  List<RestaurantItem>? categories;
  Menus? menus;
  double? rating;
  List<CustomerReview>? customerReviews;

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) =>
      RestaurantDetail(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        pictureId: json["pictureId"],
        categories: List<RestaurantItem>.from(
            json["categories"].map((x) => RestaurantItem.fromJson(x))),
        menus: Menus.fromJson(json["menus"]),
        rating: json["rating"].toDouble(),
        customerReviews: List<CustomerReview>.from(
            json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "city": city,
        "address": address,
        "pictureId": pictureId,
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
        "menus": menus!.toJson(),
        "rating": rating,
        "customerReviews":
            List<dynamic>.from(customerReviews!.map((x) => x.toJson())),
      };
}

class RestaurantItem {
  RestaurantItem({
    this.name,
  });

  String? name;

  factory RestaurantItem.fromJson(Map<String, dynamic> json) => RestaurantItem(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class Menus {
  Menus({
    this.foods,
    this.drinks,
  });

  List<RestaurantItem>? foods;
  List<RestaurantItem>? drinks;

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: List<RestaurantItem>.from(
            json["foods"].map((x) => RestaurantItem.fromJson(x))),
        drinks: List<RestaurantItem>.from(
            json["drinks"].map((x) => RestaurantItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods!.map((x) => x.toJson())),
        "drinks": List<dynamic>.from(drinks!.map((x) => x.toJson())),
      };
}
