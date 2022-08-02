import 'package:flutter/material.dart';

import '../utils/_global_variables.dart';
import '../utils/pallete.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({Key? key}) : super(key: key);

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  int _page = 0;
  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              textDirection: TextDirection.rtl,
              children: [
                Expanded(child: buildPages()),
                const VerticalDivider(width: 0),
                NavigationRail(
                  selectedIndex: _page,
                  onDestinationSelected: onPageChanged,
                  backgroundColor: kWhite,
                  elevation: 4,
                  selectedIconTheme: IconThemeData(color: kBlue, size: 28),
                  unselectedIconTheme:
                      IconThemeData(color: kBlue.withAlpha(100)),
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(
                        Icons.home,
                      ),
                      label: Text('Feed'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(
                        Icons.search,
                      ),
                      label: Text('Search'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(
                        Icons.add_circle,
                      ),
                      label: Text('Post'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(
                        Icons.gamepad,
                      ),
                      label: Text('Games'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(
                        Icons.person,
                      ),
                      label: Text('Profile'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPages() {
    return homeScreensItems[_page];
  }
}
