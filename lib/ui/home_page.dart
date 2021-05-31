import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/restaurant_list_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<Restaurant> _allRestaurantList = [];
  // List<Restaurant> _restaurantList = [];

  // Future _getRestaurantData() async {
  //   final result = await DefaultAssetBundle.of(context)
  //       .loadString('assets/local_restaurant.json');
  //   _allRestaurantList = parseRestaurant(result);
  //
  //   setState(() {
  //     _restaurantList = _allRestaurantList;
  //   });
  // }

  List<Widget> _listWidgetProvider = [
    ChangeNotifierProvider(
      create: (_) => RestaurantProvider(apiService: ApiService()),
      child: RestaurantListPage(),
    )
  ];

  Widget _appBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
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
            onChanged: (text) {
              // if (text.isEmpty) {
              //   setState(() {
              //     _restaurantList = _allRestaurantList;
              //   });
              // } else {
              //   setState(() {
              //     _restaurantList = _allRestaurantList
              //         .where((restaurant) =>
              //         restaurant.name
              //             .toLowerCase()
              //             .contains(text.toLowerCase()))
              //         .toList();
              //   });
              // }
            },
          ),
        ],
      ),
    );
  }

  // Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
  //   return GestureDetector(
  //     onTap: () {
  //       Navigator.pushNamed(context, DetailRestaurantPage.routeName,
  //           arguments: restaurant);
  //     },
  //     child: Container(
  //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //       child: Row(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Hero(
  //             tag: restaurant.pictureId,
  //             child: ClipRRect(
  //               borderRadius: BorderRadius.circular(10),
  //               child: Image.network(
  //                 restaurant.pictureId,
  //                 width: 120,
  //                 height: 100,
  //                 fit: BoxFit.cover,
  //               ),
  //             ),
  //           ),
  //           Expanded(
  //             child: Container(
  //               margin: const EdgeInsets.only(left: 8),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     restaurant.name,
  //                     style:
  //                     TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //                   ),
  //                   Text(
  //                     restaurant.description,
  //                     maxLines: 2,
  //                     overflow: TextOverflow.ellipsis,
  //                   ),
  //                   Container(
  //                     margin: const EdgeInsets.only(top: 8),
  //                     child: Row(
  //                       children: [
  //                         Icon(
  //                           Icons.location_on,
  //                           color: Colors.red,
  //                           size: 16,
  //                         ),
  //                         Text(restaurant.city),
  //                         Container(
  //                           height: 16,
  //                           child: VerticalDivider(
  //                             color: Colors.grey,
  //                             thickness: 1,
  //                           ),
  //                         ),
  //                         Icon(
  //                           Icons.star_rounded,
  //                           color: Colors.orangeAccent,
  //                           size: 16,
  //                         ),
  //                         Text(restaurant.rating),
  //                       ],
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // @override
  // void initState() {
  //   _getRestaurantData();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _appBar(),
            Expanded(
              child: _listWidgetProvider[0],
              // child: _restaurantList.length == 0
              //     ? Center(
              //   child: Text("Data restaurant tidak ditemukan"),
              // )
              //     : MediaQuery.removePadding(
              //   context: context,
              //   removeTop: true,
              //   child: ListView.builder(
              //     physics: BouncingScrollPhysics(),
              //     itemCount: _restaurantList.length,
              //     itemBuilder: (context, index) {
              //       return _buildRestaurantItem(
              //           context, _restaurantList[index]);
              //     },
              //   ),
              // ),
            )
          ],
        ),
      ),
    );
  }
}
