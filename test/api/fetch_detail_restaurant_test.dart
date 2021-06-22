import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../lib/data/api/api_service.dart';
import '../utils/dummy_data.dart';
import 'fetch_restaurants_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('fetchDetailRestaurant', () {
    final apiService = ApiService();
    final client = MockClient();

    test(
        'returns an DetailRestaurantResult if the http call completes successfully',
        () async {
      when(client.get(Uri.https(
              'restaurant-api.dicoding.dev', '/detail/rqdv5juczeskfw1e867')))
          .thenAnswer((_) async => http.Response(
              json.encode(DummyData().detailRestaurantJson), 200));

      apiService.client = client;
      final result =
          await apiService.getDetailRestaurant("rqdv5juczeskfw1e867");

      expect(result.restaurant != null, true);
      expect(result.restaurant!.id, "rqdv5juczeskfw1e867");
      expect(result.restaurant!.name, "Melting Pot");
      expect(result.restaurant!.city, "Medan");
      expect(result.restaurant!.address, "Jln. Pandeglang no 19");
    });

    test('throws an exception if the http call completes with an error', () {
      when(client.get(Uri.https(
              'restaurant-api.dicoding.dev', '/detail/rqdv5juczeskfw1e867')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      apiService.client = client;
      expect(apiService.getDetailRestaurant("rqdv5juczeskfw1e867"),
          throwsException);
    });
  });
}
