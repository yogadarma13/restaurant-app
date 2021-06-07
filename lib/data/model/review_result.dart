import 'customer_review.dart';

class ReviewResult {
  ReviewResult({
    this.error,
    this.message,
    this.customerReviews,
  });

  bool error;
  String message;
  List<CustomerReview> customerReviews;

  factory ReviewResult.fromJson(Map<String, dynamic> json) => ReviewResult(
        error: json["error"],
        message: json["message"],
        customerReviews: List<CustomerReview>.from(
            json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "customerReviews":
            List<dynamic>.from(customerReviews.map((x) => x.toJson())),
      };
}
