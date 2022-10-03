import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ytel_app/Universe/widgets/constants.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void navigationTap(int page) {
    pageController.jumpToPage(page);
    setState(() {
      _page = page;
    });
  }

  int pageIdx = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: PageView(
        children: navScreenItems, //Global Variable
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (page) {
          setState(() {
            _page = page;
          });
        },
      ),
      
      
      bottomNavigationBar:  CupertinoTabBar(
              backgroundColor: Colors.white,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: _page == 0 ? Colors.blue : Colors.grey,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.chat_bubble_rounded,
                    color: _page == 1 ? Colors.blue : Colors.grey,
                  ),
                  label: 'Chat',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person_rounded,
                    color: _page == 2 ? Colors.blue : Colors.grey,
                  ),
                  label: 'Profile',
                ),
              ],
              onTap: navigationTap,
            ),
    );
  }
}
