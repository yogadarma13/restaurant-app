import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/ui/detail_restaurant_page.dart';

import 'ui/home_page.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(
        primaryColor: primaryColor,
        accentColor: secondaryColor,
        appBarTheme: AppBarTheme(
          textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.black),
          elevation: 0,
        ),
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => HomePage(),
        DetailRestaurantPage.routeName: (context) => DetailRestaurantPage(
              restaurantId: ModalRoute.of(context).settings.arguments,
            )
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
