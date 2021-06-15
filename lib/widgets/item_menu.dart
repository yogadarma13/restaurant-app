import 'package:flutter/material.dart';

class ItemMenu extends StatelessWidget {
  final String? menuName;
  final Function onItemTap;

  const ItemMenu({Key? key, required this.menuName, required this.onItemTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onItemTap as void Function()?,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Container(
              height: 88,
              width: 88,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0,
                    spreadRadius: 0.0,
                    offset: Offset(2.0, 2.0),
                  )
                ],
              ),
              child: Image.asset(
                "assets/images/food_placeholder.png",
                width: 48,
                height: 48,
              ),
            ),
            Text(menuName!),
          ],
        ),
      ),
    );
  }
}
