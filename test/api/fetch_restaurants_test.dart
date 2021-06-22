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
  group('fetchRestaurant', () {
    final apiService = ApiService();
    final client = MockClient();

    test('returns an RestaurantResult if the http call completes successfully',
        () async {
      when(client.get(Uri.https('restaurant-api.dicoding.dev', '/list')))
          .thenAnswer((_) async =>
              http.Response(json.encode(DummyData().restaurantListJson), 200));

      apiService.client = client;
      final result = await apiService.getRestaurant();
      expect(result.restaurants?.length, 20);
    });

    test('throws an exception if the http call completes with an error', () {
      when(client.get(Uri.https('restaurant-api.dicoding.dev', '/list')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      apiService.client = client;
      expect(apiService.getRestaurant(), throwsException);
    });
  });
}
