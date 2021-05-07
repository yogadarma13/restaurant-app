import 'package:restaurant_app/data/model/menu_item.dart';

class Menu {
  List<MenuItem> foods;
  List<MenuItem> drinks;

  Menu({this.foods, this.drinks});

  Menu.fromJson(Map<String, dynamic> jsonMenu) {
    final List foodParsed = jsonMenu["foods"];
    final List drinkParsed = jsonMenu["drinks"];

    foods = foodParsed.map((food) => MenuItem.fromJson(food)).toList();
    drinks = drinkParsed.map((drink) => MenuItem.fromJson(drink)).toList();
  }
}
