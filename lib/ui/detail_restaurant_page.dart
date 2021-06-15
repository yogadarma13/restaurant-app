import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/customer_review.dart';
import 'package:restaurant_app/data/model/detail_restaurant_result.dart';
import 'package:restaurant_app/data/model/menu_page_arguments.dart';
import 'package:restaurant_app/data/model/restaurant_result.dart';
import 'package:restaurant_app/data/model/review_page_arguments.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app/ui/menu_list_page.dart';
import 'package:restaurant_app/ui/review_list_page.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widgets/item_menu.dart';
import 'package:restaurant_app/widgets/item_review.dart';
import 'package:share/share.dart';

class DetailRestaurantPage extends StatelessWidget {
  static const routeName = '/detail_restaurant_page';

  final String? restaurantId;

  const DetailRestaurantPage({required this.restaurantId});

  void _onRestaurantShare(BuildContext context, String? restaurantName) async {
    await Share.share(
        "Nikmati makanan dan minuman dari restaurant $restaurantName");
  }

  void _showMenuSelectedDialog(BuildContext context, String? itemName) {
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
            return true as dynamic;
          },
          child: MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount:
                  menus.length > 3 ? menus.sublist(0, 3).length : menus.length,
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

  Widget _buildReviewList(BuildContext context, List<CustomerReview> reviews) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowGlow();
        return true as dynamic;
      },
      child: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: ListView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: reviews.length > 3
              ? reviews.sublist(0, 3).length
              : reviews.length,
          itemBuilder: (context, index) {
            return ItemReview(
              review: reviews[index],
            );
          },
        ),
      ),
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
              RestaurantDetail restaurantDetail = state.result!.restaurant!;
              return NestedScrollView(
                headerSliverBuilder: (context, _) {
                  return [
                    SliverAppBar(
                      title: Text(restaurantDetail.name!),
                      pinned: true,
                      expandedHeight: 250,
                      actions: [
                        IconButton(
                          icon: Icon(Icons.share_rounded),
                          onPressed: () => _onRestaurantShare(
                              context, restaurantDetail.name),
                        ),
                        Consumer<DatabaseProvider>(
                          builder: (context, provider, child) {
                            return FutureBuilder<bool>(
                              future: provider.isFavorite(restaurantId!),
                              builder: (context, snapshot) {
                                var isFavorite = snapshot.data ?? false;
                                return isFavorite
                                    ? IconButton(
                                        icon: Icon(
                                          Icons.favorite_rounded,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          Fluttertoast.showToast(
                                            msg:
                                                "Restaurant dihapus dari favorit",
                                            toastLength: Toast.LENGTH_SHORT,
                                          );
                                          provider.removeRestaurantFromFavorite(
                                            restaurantId!,
                                          );
                                        },
                                      )
                                    : IconButton(
                                        icon:
                                            Icon(Icons.favorite_border_rounded),
                                        onPressed: () {
                                          Fluttertoast.showToast(
                                            msg:
                                                "Restaurant ditambahkan ke favorit",
                                            toastLength: Toast.LENGTH_SHORT,
                                          );
                                          provider.insertRestaurantFavorite(
                                            Restaurant(
                                              id: restaurantDetail.id,
                                              name: restaurantDetail.name,
                                              description:
                                                  restaurantDetail.description,
                                              pictureId:
                                                  restaurantDetail.pictureId,
                                              city: restaurantDetail.city,
                                              rating: restaurantDetail.rating,
                                            ),
                                          );
                                        },
                                      );
                              },
                            );
                          },
                        )
                      ],
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.pin,
                        background: Hero(
                          tag: restaurantDetail.pictureId!,
                          child: Image.network(
                            "https://restaurant-api.dicoding.dev/images/medium/${restaurantDetail.pictureId}",
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
                              restaurantDetail.rating.toString(),
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
                              restaurantDetail.city!,
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
                        Text(restaurantDetail.description!),
                        _buildMenuList(
                            context, "Makanan", restaurantDetail.menus!.foods!),
                        _buildMenuList(context, "Minuman",
                            restaurantDetail.menus!.drinks!),
                        SizedBox(
                          height: 16.0,
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          "Review restaurant",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        _buildReviewList(context,
                            state.result!.restaurant!.customerReviews!),
                        Center(
                          child: TextButton(
                            onPressed: () => Navigator.pushNamed(
                                context, ReviewListPage.routeName,
                                arguments: ReviewPageArguments(
                                    restaurantId: restaurantId,
                                    reviews: state
                                        .result!.restaurant!.customerReviews)),
                            child: Text(
                              "Lihat semua review",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
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
