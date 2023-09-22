import 'package:flutter/material.dart';

// ignore: camel_case_types
class Drawer_kategori extends StatefulWidget {
  final String kategoriId;
  const Drawer_kategori({Key? key, this.kategoriId = "44"}) : super(key: key);

  @override
  State<Drawer_kategori> createState() => _Drawer_kategoriState();
}

// ignore: camel_case_types
class _Drawer_kategoriState extends State<Drawer_kategori> {
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
