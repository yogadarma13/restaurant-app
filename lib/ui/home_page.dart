import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/ui/detail_restaurant_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Restaurant> allRestaurantList = [];
  List<Restaurant> restaurantList = [];

  Future _getRestaurantData() async {
    final result = await DefaultAssetBundle.of(context)
        .loadString('assets/local_restaurant.json');
    allRestaurantList = parseRestaurant(result);

    setState(() {
      restaurantList = allRestaurantList;
    });
  }

  Widget _appBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Restaurant',
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(
          height: 8,
        ),
        TextField(
          decoration: InputDecoration(
            hintText: 'Cari restaurant',
            hintStyle: TextStyle(color: Colors.grey),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey.shade400,
              size: 20,
            ),
            filled: true,
            fillColor: Colors.grey.shade100,
            contentPadding: EdgeInsets.all(8),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.blue.shade200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.grey.shade100),
            ),
          ),
          onChanged: (text) {
            if (text.isEmpty) {
              setState(() {
                restaurantList = allRestaurantList;
              });
            } else {
              setState(() {
                restaurantList = allRestaurantList
                    .where((restaurant) => restaurant.name
                        .toLowerCase()
                        .contains(text.toLowerCase()))
                    .toList();
              });
            }
          },
        ),
      ],
    );
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, DetailRestaurantPage.routeName,
            arguments: restaurant);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: restaurant.pictureId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  restaurant.pictureId,
                  width: 120,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      restaurant.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 16,
                          ),
                          Text(restaurant.city),
                          Container(
                            height: 16,
                            child: VerticalDivider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                          ),
                          Icon(
                            Icons.star_rounded,
                            color: Colors.orangeAccent,
                            size: 16,
                          ),
                          Text(restaurant.rating),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    _getRestaurantData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, _) {
          return [
            SliverAppBar(
              toolbarHeight: 110,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              pinned: true,
              expandedHeight: 120,
              title: _appBar(),
            ),
          ];
        },
        body: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView.builder(
              itemCount: restaurantList.length,
              itemBuilder: (context, index) {
                return _buildRestaurantItem(context, restaurantList[index]);
              }),
        ),
      ),
    );
  }
}
