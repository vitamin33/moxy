import 'package:flutter/material.dart';
import 'package:moxy/constant/image_path.dart';
import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class RootWebWidget extends StatelessWidget {
  const RootWebWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          elevation: 8.0,
          titleSpacing: 0.0,
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              width: 30,
              height: 30,
              ImageAssets.moxyIcLauncher,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 100,
              ),
              const SizedBox(
                width: 400, // Adjust the width as needed
                child: SegmentedTabControl(
                  backgroundColor: AppTheme.white,
                  tabPadding: EdgeInsets.all(10.0),
                  radius: Radius.circular(15.0),
                  indicatorColor: AppTheme.pinkDark,
                  tabTextColor: AppTheme.textColor,
                  selectedTabTextColor: AppTheme.white,
                  splashColor: AppTheme.pink,
                  tabs: [
                    SegmentTab(label: 'Tab 1'),
                    SegmentTab(label: 'Tab 2'),
                    SegmentTab(label: 'Tab 3'),
                    SegmentTab(label: 'Tab 4'),
                  ],
                ),
              ),
              Row(
                children: [
                  _buildPaddedIconButton(Icons.shopping_cart),
                  _buildPaddedIconButton(Icons.favorite),
                  _buildPaddedIconButton(Icons.settings),
                  _buildPaddedIconButton(Icons.person),
                ],
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Icon(Icons.directions_car),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
            Icon(Icons.directions_boat_filled),
          ],
        ),
      ),
    );
  }

  Widget _buildPaddedIconButton(IconData iconData) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
        icon: Icon(iconData),
        onPressed: () {
          // Handle button press
        },
      ),
    );
  }
}
