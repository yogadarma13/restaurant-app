import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/model/restaurant_result.dart';
import 'package:restaurant_app/utils/result_state.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getAllRestaurant();
  }

  late ResultState _resultState;

  ResultState get state => _resultState;

  String _message = '';

  String get message => _message;

  List<Restaurant> _restaurants = [];

  List<Restaurant> get restaurants => _restaurants;

  insertRestaurantFavorite(Restaurant restaurant) async {
    try {
      await databaseHelper.insertRestaurantFavorite(restaurant);
      _getAllRestaurant();
    } catch (e) {
      _resultState = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  _getAllRestaurant() async {
    try {
      _resultState = ResultState.Loading;
      notifyListeners();

      final restaurantList = await databaseHelper.getAllRestaurant();
      if (restaurantList.isEmpty) {
        _resultState = ResultState.NoData;
        notifyListeners();

        _message = "Data favorit restaurant kosong";
        return _message;
      } else {
        _resultState = ResultState.HasData;
        notifyListeners();

        _restaurants = restaurantList;
        return _restaurants;
      }
    } catch (e) {
      _resultState = ResultState.Error;
      notifyListeners();

      _message = "Tejadi kesalahan atau periksa konseksi internet anda";
      return _message;
    }
  }

  Future<bool> isFavorite(String id) async {
    final favoriteRestaurant = await databaseHelper.getRestaurantById(id);
    return favoriteRestaurant.isNotEmpty;
  }

  removeRestaurantFromFavorite(String id) async {
    try {
      await databaseHelper.removeRestaurantFromFavorite(id);
      _getAllRestaurant();
    } catch (e) {
      _resultState = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
