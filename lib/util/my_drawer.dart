import 'package:flutter/material.dart';

var myDrawer = Drawer(
  width: 200,
  backgroundColor: Colors.grey[300],
  child: Column(
    children: const [
      DrawerHeader(child: Icon(Icons.favorite)),
      ListTile(
        leading: Icon(Icons.home),
        title: Text('H A L L'),
      ),
      ListTile(
        leading: Icon(Icons.chat),
        title: Text('J O U R N E Y'),
      ),
      ListTile(
        leading: Icon(Icons.settings),
        title: Text('S E T T I N G S'),
      ),

    ],
  ),
);