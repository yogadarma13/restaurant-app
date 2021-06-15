import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/model/restaurant_result.dart';
import 'package:restaurant_app/utils/result_state.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getAllRestaurant();
  }

  late ResultState _state;

  ResultState get state => _state;

  String _message = '';

  String get message => _message;

  List<Restaurant> _restaurants = [];

  List<Restaurant> get restaurants => _restaurants;

  insertRestaurantFavorite(Restaurant restaurant) async {
    try {
      await databaseHelper.insertRestaurantFavorite(restaurant);
      _getAllRestaurant();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  _getAllRestaurant() async {
    _restaurants = await databaseHelper.getAllRestaurant();
    if (_restaurants.length > 0) {
      _state = ResultState.HasData;
    } else {
      _state = ResultState.NoData;
      _message = 'Empty Data';
    }
    notifyListeners();
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
      _state = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
