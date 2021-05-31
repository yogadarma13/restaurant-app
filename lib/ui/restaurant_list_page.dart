import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/widgets/card_restaurant.dart';

class RestaurantListPage extends StatelessWidget {
  Widget _buildRestaurantList() {
    return Consumer<RestaurantProvider>(builder: (context, state, _) {
      if (state.state == ResultState.Loading) {
        return Center(child: CircularProgressIndicator());
      } else if (state.state == ResultState.HasData) {
        return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: state.result.restaurants.length,
            itemBuilder: (context, index) {
              return CardRestaurant(
                  restaurant: state.result.restaurants[index]);
            });
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
