// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:pgmanager/components/components.dart';
import 'package:pgmanager/databaseconnection/house_db.dart';
import 'package:pgmanager/functions/show_errors.dart';
import 'package:pgmanager/model/house_model.dart';
import 'package:pgmanager/screens/inside/home_page.dart';
import 'package:pgmanager/screens/inside/home_page_revenue.dart';
import 'package:pgmanager/screens/inside/search_page.dart';

class Home extends StatefulWidget {
  final String name;
  const Home({super.key, required this.name});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  late final List<House> house;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadhouse(widget.name),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<Widget> pages = [
            HomePage(ownerName: widget.name, house: house),
            const SearchPage(),
            AllHouseRevenue(houses: house, name: widget.name),
          ];
          return SafeArea(
            child: Scaffold(
              body: pages[_selectedIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    label: 'Search',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.wallet,
                      color: Colors.white,
                    ),
                    label: 'Revenue',
                  ),
                ],
                backgroundColor: AppColor.primary.color,
              ),
            ),
          );
        } else {
          return const SafeArea(
            child: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }

  Future<void> loadhouse(String ownerName) async {
    house = await getAllHousesByOwnerAsync(ownerName);
    await updateisPayedByMonth(house);
  }

  void _onItemTapped(int index) {
    setState(
      () {
        _selectedIndex = index;
      },
    );
  }
}
