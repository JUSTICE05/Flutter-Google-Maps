import 'package:flutter/material.dart';
import '../screens/home.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Kwesi Mankata'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
              leading: Icon(Icons.supervised_user_circle),
              title: Text('Sign In/ Out'),
              onTap: () {}),
          Divider(),
          ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Favorite Locations'),
              onTap: () {}),
          Divider(),
          ListTile(
              leading: Icon(Icons.history),
              title: Text('Shipmrnt History'),
              onTap: () {}),
        ],
      ),
    );
  }
}
