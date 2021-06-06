import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/review_result.dart';
import 'package:restaurant_app/provider/result_state.dart';

class ReviewProvider extends ChangeNotifier {
  final ApiService apiService;

  ReviewProvider({@required this.apiService});

  ReviewResult _reviewResult;
  ResultState _resultState;
  String _message = '';

  ReviewResult get result => _reviewResult;

  ResultState get state => _resultState;

  String get message => _message;

  addNewReview(String restaurantId, String name, String review) async {
    try {
      _resultState = ResultState.Loading;
      notifyListeners();

      final reviewData =
          await apiService.addNewReview(restaurantId, name, review);
      if (reviewData.customerReviews.isEmpty) {
        _resultState = ResultState.NoData;
        notifyListeners();

        _message = "Berhasil menambahkan review";
        return _message;
      } else {
        _resultState = ResultState.HasData;
        notifyListeners();

        _message = "Berhasil menambahkan review";
        _reviewResult = reviewData;
        return _reviewResult;
      }
    } catch (e) {
      _resultState = ResultState.Error;
      notifyListeners();

      _message = "Terjadi kesalahan";
      return _message;
    }
  }
}
