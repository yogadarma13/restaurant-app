import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/home_page.dart';

Widget createHomeScreen() => ChangeNotifierProvider<RestaurantProvider>(
      create: (context) => RestaurantProvider(
        apiService: ApiService(),
      ),
      child: MaterialApp(
        home: HomePage(),
      ),
    );

void main() {
  group('home page test', () {
    testWidgets('Test app bar show', (WidgetTester tester) async {
      await tester.pumpWidget(createHomeScreen());
      expect(find.text('Restaurant'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });
  });
}
