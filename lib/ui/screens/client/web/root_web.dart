import 'package:flutter/material.dart';

class RootWebWidget extends StatelessWidget {
  const RootWebWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Center(
        child: Text('Content goes here'),
      ),
    );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppTabTitle(title: 'Tab 1', isSelected: true),
          AppTabTitle(title: 'Tab 2', isSelected: false),
          AppTabTitle(title: 'Tab 3', isSelected: false),
          AppTabTitle(title: 'Tab 4', isSelected: false),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {
            // Handle shopping cart button press
          },
        ),
        IconButton(
          icon: Icon(Icons.favorite),
          onPressed: () {
            // Handle favorite button press
          },
        ),
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            // Handle settings button press
          },
        ),
        IconButton(
          icon: Icon(Icons.person),
          onPressed: () {
            // Handle profile button press
          },
        ),
      ],
    );
  }
}

class AppTabTitle extends StatelessWidget {
  final String title;
  final bool isSelected;

  AppTabTitle({required this.title, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          color: isSelected ? Colors.blue : Colors.black,
        ),
      ),
    );
  }
}
