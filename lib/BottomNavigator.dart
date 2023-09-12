import 'package:cancer_project/MyHomePage.dart';
import 'package:flutter/material.dart';

import 'ChatApp/ChatPage.dart';
import 'Settings/Profile.dart';


class BottomNavigatorWidget extends StatefulWidget {
  const BottomNavigatorWidget({super.key});

  @override
  State<BottomNavigatorWidget> createState() => _BottomNavigatorWidgetState();
}

class _BottomNavigatorWidgetState extends State<BottomNavigatorWidget> {
  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static final List<Widget> _widgetOptions = <Widget>[
    const ChatPage(),
    const MyHomePage(),
    const ProfileWidget(),
  ];
  decoration() {
    if (_selectedIndex == 1) {
      return const BoxDecoration(color: Colors.white);
      return const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("Assets/black1.png"), fit: BoxFit.fitHeight));
    } else {
      return const BoxDecoration(color: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: decoration(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: _widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 30,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey.shade600,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.mail),
                label: "Inbox",
                //activeIcon: ChatPage()
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.groups),
                label: "Community",
                //activeIcon: Tik_Tak_Game()
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_pin),
                label: "Profile",
                //activeIcon: UserProfile()
              ),
            ],
          ),
        ));
  }
}
