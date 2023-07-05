import 'package:flutter/material.dart';

class RootWebWidget extends StatefulWidget {
  const RootWebWidget({super.key});

  @override
  _RootWebWidgetState createState() => _RootWebWidgetState();
}

class _RootWebWidgetState extends State<RootWebWidget> {
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
    return DefaultTabController(
      length: _pages.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: AppBar(
            title: Row(
              children: [
                Image.asset('assets/icons/moxy_icon.png',
                    height: 40.0), //replace with your asset
                SizedBox(
                    width: 50), // spacing between logo and category buttons
                TabBar(
                  onTap: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  tabs: [
                    Tab(text: 'Category 1'),
                    Tab(text: 'Category 2'),
                    Tab(text: 'Category 3'),
                    // add more tabs as needed
                  ],
                ),
              ],
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
        ),
        body: Column(
          children: [
            Divider(
              height: 1,
              thickness: 1,
            ),
            Expanded(
              child: TabBarView(
                children: _pages,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
