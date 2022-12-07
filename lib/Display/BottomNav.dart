import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:insekul_app/Pages/Home.dart';
import 'package:insekul_app/Pages/Search.dart';
import 'package:insekul_app/Pages/Notification.dart';
import 'package:insekul_app/Pages/MyAccount.dart';

class BottomNavigation extends StatefulWidget {

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  // List pages = [
  //   HomePage(),
  //   SearchPage(),
  //   NotificationPage(),
  //   MyAccount(),
  // ];

  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          HomePage(),
          SearchPage(),
          NotificationPage(),
          MyAccount(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 10,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Ionicons.home_outline),
              label: ''
          ),
          BottomNavigationBarItem(
              icon: Icon(Ionicons.search_outline),
              label: ''
          ),
          BottomNavigationBarItem(
              icon: Icon(Ionicons.notifications_outline),
              label: ''
          ),
          BottomNavigationBarItem(
              icon: Icon(Ionicons.person_outline),
              label: ''
          ),
        ],
      ),
    );
  }
}
