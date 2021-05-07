import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/detail_restaurant_page.dart';

import 'ui/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => HomePage(),
        DetailRestaurantPage.routeName: (context) => DetailRestaurantPage(
              restaurant: ModalRoute.of(context).settings.arguments,
            )
      },
    );
  }
}
