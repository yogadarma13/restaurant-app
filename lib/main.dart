import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/model/menu_page_arguments.dart';
import 'package:restaurant_app/data/model/review_page_arguments.dart';
import 'package:restaurant_app/data/preferences/preferences_helper.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/provider/review_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/ui/detail_restaurant_page.dart';
import 'package:restaurant_app/ui/favorite_restaurant_page.dart';
import 'package:restaurant_app/ui/menu_list_page.dart';
import 'package:restaurant_app/ui/review_list_page.dart';
import 'package:restaurant_app/ui/settings_page.dart';
import 'package:restaurant_app/utils/backgroud_service.dart';
import 'package:restaurant_app/utils/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ui/home_page.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  // if (Platform.isAndroid) {
    AndroidAlarmManager.initialize();
  // }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  HttpOverrides.global = MyHttpOverrides();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestaurantProvider(
            apiService: ApiService(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ReviewProvider(
            apiService: ApiService(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(
            databaseHelper: DatabaseHelper(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
      ],
      child: MaterialApp(
        title: 'Restaurant App',
        theme: ThemeData(
          primaryColor: primaryColor,
          accentColor: secondaryColor,
          appBarTheme: AppBarTheme(
            textTheme:
                Theme.of(context).textTheme.apply(bodyColor: Colors.black),
            elevation: 0,
          ),
        ),
        navigatorKey: navigatorKey,
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
                    restaurantId: settings.arguments as String?),
              );
            case MenuListPage.routeName:
              return MaterialPageRoute(
                builder: (context) => MenuListPage(
                  args: settings.arguments as MenuPageArguments?,
                ),
              );
            case ReviewListPage.routeName:
              return MaterialPageRoute(
                builder: (context) => ReviewListPage(
                  args: settings.arguments as ReviewPageArguments?,
                ),
              );
            case FavoriteRestaurantPage.routeName:
              return MaterialPageRoute(
                builder: (context) => FavoriteRestaurantPage(),
              );
            case SettingsPage.routeName:
              return MaterialPageRoute(
                builder: (context) => SettingsPage(),
              );
            default:
              return null;
          }
        },
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
