import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/menu_page_arguments.dart';
import 'package:restaurant_app/data/model/review_page_arguments.dart';
import 'package:restaurant_app/ui/detail_restaurant_page.dart';
import 'package:restaurant_app/ui/menu_list_page.dart';
import 'package:restaurant_app/ui/review_list_page.dart';

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
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case HomePage.routeName:
            return MaterialPageRoute(
              builder: (context) => HomePage(),
            );
          case DetailRestaurantPage.routeName:
            return MaterialPageRoute(
              builder: (context) => DetailRestaurantPage(
                  restaurantId: settings.arguments as String),
            );
          case MenuListPage.routeName:
            return MaterialPageRoute(
              builder: (context) => MenuListPage(
                args: settings.arguments as MenuPageArguments,
              ),
            );
          case ReviewListPage.routeName:
            return MaterialPageRoute(
              builder: (context) => ReviewListPage(
                args: settings.arguments as ReviewPageArguments,
              ),
            );
          default:
            return null;
        }
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
