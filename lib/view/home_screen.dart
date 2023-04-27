import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_admin/view/profile_screen.dart';

import '../view_model/nav_provider.dart';
import 'menu_items_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Widget> _widgetOptions = <Widget>[MenuItemListScreen() , ProfileScreen(),];

  @override
  Widget build(BuildContext context) {
    final nav_provider = Provider.of<NavProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: _widgetOptions.elementAt(nav_provider.index),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
        currentIndex: nav_provider.index,
        onTap: (int index) async {
          nav_provider.changeIndex(index);
        },
      ),
    );
  }
}