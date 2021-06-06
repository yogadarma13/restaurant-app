import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/menu_page_arguments.dart';
import 'package:restaurant_app/widgets/item_menu.dart';

class MenuListPage extends StatelessWidget {
  static const routeName = '/menu_list_page';

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

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as MenuPageArguments;
    final appbarTitle = args.appbarTitle;
    final menus = args.menus;

    return Scaffold(
      appBar: AppBar(
        title: Text(appbarTitle),
      ),
      body: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: ListView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: menus.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ItemMenu(
                menuName: menus[index].name,
                onItemTap: () =>
                    _showMenuSelectedDialog(context, menus[index].name),
              ),
            );
          },
        ),
      ),
    );
  }
}
