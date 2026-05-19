import 'package:flutter/material.dart';

import 'arac_list_screen.dart';
import 'musteri_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  static const _screens = [
    AracListScreen(),
    MusteriListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.directions_car), label: 'Araçlar'),
          NavigationDestination(icon: Icon(Icons.people), label: 'Müşteriler'),
        ],
      ),
    );
  }
}
