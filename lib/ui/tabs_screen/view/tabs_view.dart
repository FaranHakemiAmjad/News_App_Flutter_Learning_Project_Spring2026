import 'package:flutter/material.dart';

import '../../home_screen/view/home_view.dart';
import '../../saved_screen/view/saved_view.dart';

class TabsView extends StatefulWidget {
  const TabsView({super.key});

  @override
  State<TabsView> createState() => _TabsViewState();
}

class _TabsViewState extends State<TabsView> {

  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeView(),
    SavedView()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: _selectedIndex !=0 ? Icon(Icons.home_outlined) : Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(icon: _selectedIndex !=1 ? Icon(Icons.bookmark_outline) : Icon(Icons.bookmark_outlined), label: "Saved"),
        ],
      ),
    );
  }
}
