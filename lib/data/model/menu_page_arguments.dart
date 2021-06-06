import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/model/detail_restaurant_result.dart';

class MenuPageArguments {
  final String appbarTitle;
  final List<RestaurantItem> menus;

  MenuPageArguments({@required this.appbarTitle, @required this.menus});
}
