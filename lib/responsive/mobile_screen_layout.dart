import '../utils/_global_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/pallete.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: homeScreensItems,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: kBlue,
        height: 60,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home,
                  color: _page == 0 ? kWhite : kWhite.withAlpha(100)),
              label: '',
              backgroundColor: kBlue),
          BottomNavigationBarItem(
              icon: Icon(Icons.search,
                  color: _page == 1 ? kWhite : kWhite.withAlpha(100)),
              label: '',
              backgroundColor: kBlue),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle,
                  color: _page == 2 ? kWhite : kWhite.withAlpha(100)),
              label: '',
              backgroundColor: kBlue),
          BottomNavigationBarItem(
              icon: Icon(Icons.gamepad,
                  color: _page == 3 ? kWhite : kWhite.withAlpha(100)),
              label: '',
              backgroundColor: kBlue),
          BottomNavigationBarItem(
              icon: Icon(Icons.person,
                  color: _page == 4 ? kWhite : kWhite.withAlpha(100)),
              label: '',
              backgroundColor: kBlue),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
