import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant_result.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/provider/result_state.dart';
import 'package:restaurant_app/widgets/card_restaurant.dart';

import 'detail_restaurant_page.dart';

class RestaurantListPage extends StatelessWidget {
  Widget _buildRestaurantList() {
    return Consumer<RestaurantProvider>(builder: (context, state, _) {
      if (state.state == ResultState.Loading) {
        return Center(child: CircularProgressIndicator());
      } else if (state.state == ResultState.HasData) {
        List<Restaurant> restaurantList = state.result!.restaurants!;
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: restaurantList.length,
          itemBuilder: (context, index) {
            return CardRestaurant(
              restaurant: restaurantList[index],
              onItemTap: () => Navigator.pushNamed(
                  context, DetailRestaurantPage.routeName,
                  arguments: restaurantList[index].id),
            );
          },
        );
      } else if (state.state == ResultState.NoData) {
        return Center(child: Text(state.message));
      } else if (state.state == ResultState.Error) {
        return Center(child: Text(state.message));
      } else {
        return Center(child: Text(""));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildRestaurantList();
  }
}
