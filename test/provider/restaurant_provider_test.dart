import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';

void main() {
  test('check restaurant data more than one', () async {
    var restaurantProvider = RestaurantProvider(apiService: ApiService());

    await Future.delayed(Duration(seconds: 3), () {});
    var result = restaurantProvider.result?.restaurants;

    expect(result?.isNotEmpty, true);
    expect(result!.length > 1, true);
  });
}
