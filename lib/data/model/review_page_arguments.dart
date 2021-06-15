import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/model/customer_review.dart';

class ReviewPageArguments {
  final String? restaurantId;
  final List<CustomerReview>? reviews;

  ReviewPageArguments({required this.restaurantId, required this.reviews});
}
