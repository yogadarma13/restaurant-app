class MenuItem {
  String name;

  MenuItem({this.name});

  MenuItem.fromJson(Map<String, dynamic> jsonFood) {
    name = jsonFood["name"];
  }
}
