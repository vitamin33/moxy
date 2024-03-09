import 'package:flutter/material.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class RootMobileWidget extends StatefulWidget {
  const RootMobileWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RootMobileWidgetState createState() => _RootMobileWidgetState();
}

class _RootMobileWidgetState extends State<RootMobileWidget> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;
    final List<Widget> pages = <Widget>[
      Text(
        'Home Page',
        style: theme.titleSemiBoltText,
      ),
      Text(
        'Favorites Page',
        style: theme.titleSemiBoltText,
      ),
      Text(
        'Profile Page',
        style: theme.titleSemiBoltText,
      ),
      Text(
        'Basket Page',
        style: theme.titleSemiBoltText,
      ),
      // Add more pages as needed
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Moxy Store',
          style: theme.titleSemiBoltText,
        ),
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
                  child: const Text('Category 1'),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  },
                ),
                TextButton(
                  child: const Text('Category 2'),
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
              child: pages.elementAt(_selectedIndex),
            ),
          ),
        ],
      ),
    );
  }
}
