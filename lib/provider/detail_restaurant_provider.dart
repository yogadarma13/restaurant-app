import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/detail_restaurant_result.dart';
import 'package:restaurant_app/provider/result_state.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String? restaurantId;

  DetailRestaurantProvider(
      {required this.apiService, required this.restaurantId}) {
    _getDetailRestaurant();
  }

  DetailRestaurantResult? _detailResult;
  ResultState? _resultState;
  String _message = '';

  String get message => _message;

  DetailRestaurantResult? get result => _detailResult;

  ResultState? get state => _resultState;

  _getDetailRestaurant() async {
    try {
      _resultState = ResultState.Loading;
      notifyListeners();

      final detailRestaurant =
          await apiService.getDetailRestaurant(restaurantId);
      if (detailRestaurant.error == true) {
        _resultState = ResultState.NoData;
        notifyListeners();

        _message = "Data restaurant kosong";
        return _message;
      } else {
        _resultState = ResultState.HasData;
        notifyListeners();

        _detailResult = detailRestaurant;
        return _detailResult;
      }
    } catch (e) {
      _resultState = ResultState.Error;
      notifyListeners();

      _message = "Tejadi kesalahan atau periksa koneksi internet anda";
      return _message;
    }
  }
}
