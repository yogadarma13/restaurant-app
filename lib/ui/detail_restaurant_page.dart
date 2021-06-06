import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/detail_restaurant_result.dart';
import 'package:restaurant_app/data/model/menu_page_arguments.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app/provider/result_state.dart';
import 'package:restaurant_app/ui/menu_list_page.dart';
import 'package:restaurant_app/widgets/item_menu.dart';
import 'package:share/share.dart';

class DetailRestaurantPage extends StatelessWidget {
  static const routeName = '/detail_restaurant_page';

  final String restaurantId;

  const DetailRestaurantPage({@required this.restaurantId});

  void _onRestaurantShare(BuildContext context, String restaurantName) async {
    await Share.share(
        "Nikmati makanan dan minuman dari restaurant $restaurantName");
  }

  void _showMenuSelectedDialog(BuildContext context, String itemName) {
    defaultTargetPlatform == TargetPlatform.iOS
        ? showCupertinoDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return CupertinoAlertDialog(
                title: Text('Menu'),
                content: Text('Apakah memilih menu $itemName'),
                actions: [
                  CupertinoDialogAction(
                    child: Text('Oke'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          )
        : showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Menu'),
                content: Text('Anda memilih menu $itemName'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Oke'),
                  ),
                ],
              );
            },
          );
  }

  Widget _buildMenuList(
      BuildContext context, String title, List<RestaurantItem> menus) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                child: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(
                context,
                MenuListPage.routeName,
                arguments:
                    MenuPageArguments(appbarTitle: "Menu $title", menus: menus),
              ),
              child: Text(
                "Lihat semua",
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ),
          ],
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
              itemCount: menus.sublist(0, 3).length,
              itemBuilder: (context, index) {
                return ItemMenu(
                  menuName: menus[index].name,
                  onItemTap: () =>
                      _showMenuSelectedDialog(context, menus[index].name),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => DetailRestaurantProvider(
            apiService: ApiService(), restaurantId: restaurantId),
        child: Consumer<DetailRestaurantProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.HasData) {
              Restaurant restaurant = state.result.restaurant;
              return NestedScrollView(
                headerSliverBuilder: (context, _) {
                  return [
                    SliverAppBar(
                      title: Text(restaurant.name),
                      pinned: true,
                      expandedHeight: 250,
                      actions: [
                        IconButton(
                          icon: Icon(Icons.share_rounded),
                          onPressed: () =>
                              _onRestaurantShare(context, restaurant.name),
                        )
                      ],
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.pin,
                        background: Hero(
                          tag: restaurant.pictureId,
                          child: Image.network(
                            "https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}",
                            fit: BoxFit.cover,
                          ),
                        ),
                        titlePadding:
                            const EdgeInsets.only(left: 16, bottom: 16),
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
                              restaurant.rating.toString(),
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
                          margin: const EdgeInsets.only(top: 16, bottom: 8),
                          child: Text(
                            "Deskripsi restaurant",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        Text(restaurant.description),
                        _buildMenuList(
                            context, "Makanan", restaurant.menus.foods),
                        _buildMenuList(
                            context, "Minuman", restaurant.menus.drinks)
                      ],
                    ),
                  ),
                ),
              );
            } else if (state.state == ResultState.NoData) {
              return Center(child: Text(state.message));
            } else if (state.state == ResultState.Error) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text(""));
            }
          },
        ),
      ),
    );
  }
}
