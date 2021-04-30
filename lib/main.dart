import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  Widget _buildList(BuildContext context) {
    return FutureBuilder(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/local_restaurant.json'),
        builder: (context, snapshot) {
          final List<Restaurant> restaurant = parseRestaurant(snapshot.data);
          return ListView.builder(
              itemCount: restaurant.length,
              itemBuilder: (context, index) {
                return Text(restaurant[index].menus.foods[0].name);
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildList(context),
    );
  }
}
