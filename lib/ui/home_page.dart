import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/favorite_restaurant_page.dart';
import 'package:restaurant_app/ui/restaurant_list_page.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';

  Widget _appBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Restaurant',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              IconButton(
                icon: Icon(Icons.favorite_rounded),
                onPressed: () => Navigator.pushNamed(
                    context, FavoriteRestaurantPage.routeName),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Consumer<RestaurantProvider>(
            builder: (context, state, _) {
              return TextField(
                decoration: InputDecoration(
                  hintText: 'Cari restaurant atau menu',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade400,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: const EdgeInsets.all(8),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.blue.shade400),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.grey.shade100),
                  ),
                ),
                onChanged: (text) async {
                  await state.searchRestaurant(text);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _appBar(context),
            Expanded(
              child: RestaurantListPage(),
            )
          ],
        ),
      ),
    );
  }
}
