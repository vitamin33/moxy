import 'package:flutter/material.dart';

class RootMobileWidget extends StatefulWidget {
  const RootMobileWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RootMobileWidgetState createState() => _RootMobileWidgetState();
}

class _RootMobileWidgetState extends State<RootMobileWidget> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    Text('Home Page'),
    Text('Favorites Page'),
    Text('Profile Page'),
    Text('Basket Page'),
    // Add more pages as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moxy Store'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              setState(() {
                _selectedIndex = 0;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              setState(() {
                _selectedIndex = 1;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              setState(() {
                _selectedIndex = 2;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_basket),
            onPressed: () {
              setState(() {
                _selectedIndex = 3;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.grey[300],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: Text('Category 1'),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  },
                ),
                TextButton(
                  child: Text('Category 2'),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 1;
                    });
                  },
                ),
                // Add more categories as needed
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: _pages.elementAt(_selectedIndex),
            ),
          ),
        ],
      ),
    );
  }
}
