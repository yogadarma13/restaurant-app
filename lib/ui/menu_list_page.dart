import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/menu_page_arguments.dart';
import 'package:restaurant_app/widgets/item_menu.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';

class MenuListPage extends StatelessWidget {
  static const routeName = '/menu_list_page';

  final MenuPageArguments args;

  MenuListPage({@required this.args});

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(args.appbarTitle),
      ),
      body: _buildMenuList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(args.appbarTitle),
      ),
      child: _buildMenuList(context),
    );
  }

  Widget _buildMenuList(BuildContext context) {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: args.menus.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ItemMenu(
              menuName: args.menus[index].name,
              onItemTap: () =>
                  _showMenuSelectedDialog(context, args.menus[index].name),
            ),
          );
        },
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }
}
