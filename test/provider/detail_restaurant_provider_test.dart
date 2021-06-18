import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';

void main() {
  test('check detail restaurant with id rqdv5juczeskfw1e867 not empty',
      () async {
    var detailRestaurantProvider = DetailRestaurantProvider(
        apiService: ApiService(), restaurantId: 'rqdv5juczeskfw1e867');

    await Future.delayed(Duration(seconds: 3), () {});
    var result = detailRestaurantProvider.result?.restaurant;

    expect(result != null, true);
    expect(result!.name, 'Melting Pot');
  });
}
