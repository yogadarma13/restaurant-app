import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/model/detail_restaurant_result.dart';

import '../utils/dummy_data.dart';

void main() {
  test('parsing detail restaurant map to detail restaurant result model', () {
    final DetailRestaurantResult detailRestaurantResult =
        DetailRestaurantResult.fromJson(DummyData().detailRestaurantJson);

    expect(detailRestaurantResult.restaurant!.id, 'rqdv5juczeskfw1e867');
    expect(detailRestaurantResult.restaurant!.name, 'Melting Pot');
    expect(detailRestaurantResult.restaurant!.description,
        'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.');
    expect(detailRestaurantResult.restaurant!.pictureId, '14');
    expect(detailRestaurantResult.restaurant!.city, 'Medan');
    expect(detailRestaurantResult.restaurant!.rating, 4.2);
  });
}
