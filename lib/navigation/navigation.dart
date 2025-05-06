import 'package:flutter/material.dart';
import 'package:readspace/screens/favorite/favorite_screen.dart';
import 'package:readspace/screens/home/home_screen.dart';
import 'package:readspace/screens/profile/profile_screen.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.purple.shade400,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                  _selectedIndex == 0 ? Icons.home : Icons.home_outlined,
              ),
              label: "Home",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                  _selectedIndex == 1 ? Icons.favorite : Icons.favorite_border_outlined
              ),
              label: "Favorite",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                  _selectedIndex == 2 ? Icons.person : Icons.person_outline
              ),
              label: "Profile",
          ),
        ],
      ),
    );
  }
}