import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smollan_assignment/view/addPost.dart';
import 'package:smollan_assignment/view/feed.dart';
import 'package:smollan_assignment/view/profile.dart';
import 'package:smollan_assignment/view/reel.dart';
import 'package:smollan_assignment/view/search.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    print("object");
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final _icons = [
      _svgIcon('assets/icons/homef.svg', isDarkMode),
      _svgIcon('assets/icons/searchf.svg', isDarkMode),
      _svgIcon('assets/icons/add.svg', isDarkMode),
      _icon(Icons.favorite, isDarkMode),
      _icon(Icons.account_circle, isDarkMode),
    ];

    // Icons for the unselected state (use different icons or colors if needed)
    final _unselectedIcons = [
      _svgIcon('assets/icons/home.svg', isDarkMode),
      _svgIcon('assets/icons/search.svg', isDarkMode),
      _svgIcon('assets/icons/add.svg', isDarkMode),
      _icon(Icons.favorite_border_outlined, isDarkMode),
      _icon(Icons.account_circle_outlined, isDarkMode),
    ];

    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: const [
          Feed(),
          SearchPage(),
          AddPostPage(),
          ActivityPage(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(5, (index) {
            return InkWell(
              onTap: () => _onItemTapped(index),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _selectedIndex == index
                      ? _icons[index]
                      : _unselectedIcons[index],
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _svgIcon(String asset, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SvgPicture.asset(
        asset,
        colorFilter: ColorFilter.mode(
          isDarkMode ? Colors.white : Colors.black,
          BlendMode.srcIn,
        ),
      ),
    );
  }

  Widget _icon(IconData icon, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Icon(
        icon,
        color: isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }
}
