import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant_result.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widgets/card_restaurant.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';

import 'detail_restaurant_page.dart';

class FavoriteRestaurantPage extends StatelessWidget {
  static const routeName = '/favorite_restaurant_page';
  static const title = "Favorite Restaurant";

  const FavoriteRestaurantPage({Key? key}) : super(key: key);

  Widget _buildAndroid(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, state, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: _buildFavoriteList(context),
        );
      },
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(title),
      ),
      child: _buildFavoriteList(context),
    );
  }

  Widget _buildFavoriteList(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.HasData) {
          List<Restaurant> restaurantList = state.restaurants;
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
