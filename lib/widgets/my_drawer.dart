import 'package:flutter/material.dart';

import 'package:healthdiary/pages/client/home_page_client.dart';
import 'package:healthdiary/pages/client/fooddiary/food_diary_page.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Header do drawer'),
            decoration: BoxDecoration(
              color: Colors.pinkAccent,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text("Home"),
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomePageClient()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.fastfood),
            title: Text("Diário alimentar"),
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => FoodDiaryPage()));
            },
          ),
        ],
      ),
    );
  }
}
