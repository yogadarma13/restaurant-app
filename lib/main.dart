import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/ui/detail_restaurant_page.dart';

import 'ui/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(
        primaryColor: primaryColor,
        appBarTheme: AppBarTheme(
          textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.black),
          elevation: 0,
        ),
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
