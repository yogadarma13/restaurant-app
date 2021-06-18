import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/model/restaurant_result.dart';

import '../utils/dummy_data.dart';

void main() {
  test('parsing restaurant map to restaurant result model', () {
    final RestaurantResult restaurantResult =
        RestaurantResult.fromJson(DummyData().restaurantListJson);

    expect(restaurantResult.restaurants?.isNotEmpty, true);
    expect(restaurantResult.restaurants!.length, 20);
    expect(restaurantResult.restaurants![0].id, 'rqdv5juczeskfw1e867');
    expect(restaurantResult.restaurants![0].name, 'Melting Pot');
    expect(restaurantResult.restaurants![0].description,
        'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.');
    expect(restaurantResult.restaurants![0].pictureId, '14');
    expect(restaurantResult.restaurants![0].city, 'Medan');
    expect(restaurantResult.restaurants![0].rating, 4.2);
  });
}
