import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_result.dart';
import 'package:restaurant_app/provider/result_state.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({@required this.apiService}) {
    _fetchAllRestaurant();
  }

  RestaurantResult _restaurantResult;
  ResultState _resultState;
  String _message = '';

  String get message => _message;

  RestaurantResult get result => _restaurantResult;

  ResultState get state => _resultState;

  _fetchAllRestaurant() async {
    try {
      _resultState = ResultState.Loading;
      notifyListeners();

      final restaurant = await apiService.getRestaurant();
      if (restaurant.restaurants.isEmpty) {
        _resultState = ResultState.NoData;
        notifyListeners();

        _message = "Data restaurant kosong";
        return _message;
      } else {
        _resultState = ResultState.HasData;
        notifyListeners();

        _restaurantResult = restaurant;
        return _restaurantResult;
      }
    } catch (e) {
      _resultState = ResultState.Error;
      notifyListeners();

      _message = "Tejadi kesalahan atau periksa konseksi internet anda";
      return _message;
    }
  }

  searchRestaurant(String query) async {
    try {
      _resultState = ResultState.Loading;
      notifyListeners();

      final restaurant = await apiService.searchRestaurant(query);
      if (restaurant.restaurants.isEmpty) {
        _resultState = ResultState.NoData;
        notifyListeners();

        _message = "Restaurant tidak ditemukan";
        return _message;
      } else {
        _resultState = ResultState.HasData;
        notifyListeners();

        _restaurantResult = restaurant;
        return _restaurantResult;
      }
    } catch (e) {
      _resultState = ResultState.Error;
      notifyListeners();

      _message = "Tejadi kesalahan atau periksa koneksi internet anda";
      return _message;
    }
  }
}
