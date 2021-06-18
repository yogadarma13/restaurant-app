import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/customer_review.dart';

class ItemReview extends StatelessWidget {
  final CustomerReview review;

  ItemReview({required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: 16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: FadeInImage(
                width: 60.0,
                height: 60.0,
                placeholder:
                    AssetImage("assets/images/ic_profile_placeholder.png"),
                image: NetworkImage(
                    "https://i.pravatar.cc/80?u=${review.name!.trim()}"),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  review.date!,
                  style: TextStyle(fontSize: 12.0, color: Colors.grey),
                ),
                Text(
                  (review.name == null || review.name!.isEmpty)
                      ? "-"
                      : review.name!,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8.0),
                  child: Text((review.review == null || review.review!.isEmpty)
                      ? "-"
                      : review.review!),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
