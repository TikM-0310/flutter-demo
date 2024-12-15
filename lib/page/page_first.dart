// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:my_vlog/page/page_homes.dart';
import 'package:my_vlog/page/page_profile.dart';
import 'package:my_vlog/page/page_setting.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}
 
class _FirstPageState extends State<FirstPage> {
  
  void _navgateButtom (int index)
  {
    setState(() {
      _pageIndex = index;
    });
  }

  final List _pages = [
    HomePage(),
    ProfilePage(),  
    SettingPage()
  ];

  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("first Page"),
        backgroundColor: Colors.purple,
      ),
      body: _pages[_pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: _navgateButtom,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),

        ] 
      ),
    );
  }
}
 