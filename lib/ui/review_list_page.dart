import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/customer_review.dart';
import 'package:restaurant_app/data/model/review_page_arguments.dart';
import 'package:restaurant_app/provider/result_state.dart';
import 'package:restaurant_app/provider/review_provider.dart';
import 'package:restaurant_app/widgets/custom_add_review_dialog.dart';
import 'package:restaurant_app/widgets/item_review.dart';

class ReviewListPage extends StatelessWidget {
  static const routeName = '/review_list_page';

  Widget _buildReviewList(List<CustomerReview> reviews) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: ItemReview(
            review: reviews[index],
          ),
        );
      },
    );
  }

  Widget _buildWidget(BuildContext context, ReviewProvider state,
      List<CustomerReview> reviews) {
    if (state.state == ResultState.HasData) {
      Fluttertoast.showToast(
          msg: state.message, toastLength: Toast.LENGTH_SHORT);
      Navigator.pop(context);
      return _buildReviewList(state.result.customerReviews);
    } else if (state.state == ResultState.NoData) {
      Fluttertoast.showToast(
          msg: state.message, toastLength: Toast.LENGTH_SHORT);
      Navigator.pop(context);
      return Container();
    } else if (state.state == ResultState.Error) {
      Fluttertoast.showToast(
          msg: state.message, toastLength: Toast.LENGTH_SHORT);
      return Container();
    } else {
      return _buildReviewList(reviews);
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as ReviewPageArguments;
    final restaurantId = args.restaurantId;
    final reviews = args.reviews;

    return ChangeNotifierProvider(
      create: (_) => ReviewProvider(
        apiService: ApiService(),
      ),
      child: Consumer<ReviewProvider>(
        builder: (context, state, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Review Restaurant"),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => CustomAddReviewDialog(
                  restaurantId: restaurantId,
                  addReview: state.addNewReview,
                ),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              backgroundColor: Colors.blue,
            ),
            body: _buildWidget(context, state, reviews),
          );
        },
      ),
    );
  }
}
