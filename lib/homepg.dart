import 'package:bagwan/home.dart';
import 'package:bagwan/info.dart';
import 'package:bagwan/shpments.dart';
import 'package:flutter/material.dart';


class Homepg extends StatefulWidget {
  const Homepg({Key? key}) : super(key: key);

  @override
  State<Homepg> createState() => _HomepgState();
}

class _HomepgState extends State<Homepg> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const Home(),
    const FirestoreDataScreen(),
    const Info(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'MY SHIPMENTS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'INFO',
          ),
        ],
      ),
    );
  }
}

