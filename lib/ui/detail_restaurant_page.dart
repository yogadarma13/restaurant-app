import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/menu_item.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class DetailRestaurantPage extends StatelessWidget {
  static const routeName = '/detail_restaurant_page';

  final Restaurant restaurant;

  const DetailRestaurantPage({@required this.restaurant});

  Widget _buildMenuList(
      BuildContext context, String title, List<MenuItem> menus) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16, bottom: 8),
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowGlow();
            return;
          },
          child: MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: menus.length,
              itemBuilder: (context, index) {
                return _buildMenuItem(menus[index].name);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(String itemName) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Row(children: [
        Container(
          height: 88,
          width: 88,
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 2.0,
                spreadRadius: 0.0,
                offset: Offset(2.0, 2.0), // shadow direction: bottom right
              )
            ],
          ),
          child: Image.asset(
            "assets/images/food_placeholder.png",
            width: 48,
            height: 48,
          ),
        ),
        Text(itemName),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, _) {
          return [
            SliverAppBar(
              title: Text(restaurant.name),
              pinned: true,
              expandedHeight: 250,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Hero(
                  tag: restaurant.pictureId,
                  child: Image.network(
                    restaurant.pictureId,
                    fit: BoxFit.cover,
                  ),
                ),
                titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
              ),
            )
          ];
        },
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: Colors.orangeAccent,
                      size: 20,
                    ),
                    Text(
                      restaurant.rating,
                      style: TextStyle(fontSize: 16),
                    ),
                    Container(
                      height: 16,
                      child: VerticalDivider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                    ),
                    Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 20,
                    ),
                    Text(
                      restaurant.city,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 16, bottom: 8),
                  child: Text(
                    "Deskripsi restaurant",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Text(restaurant.description),
                _buildMenuList(context, "Makanan", restaurant.menus.foods),
                _buildMenuList(context, "Minuman", restaurant.menus.drinks)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
