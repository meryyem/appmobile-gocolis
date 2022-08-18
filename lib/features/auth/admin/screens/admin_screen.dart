import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:gocolis/constants/colors.dart';
import 'package:gocolis/constants/global_variables.dart';
import 'package:gocolis/features/auth/sender/screens/delivery_requests_screen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
    int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const DeliveryRequestsScreen(),
    const Center(child: Text('Analytics Page'),),
    const Center(child: Text('Cart Page'),),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Text('app name!!!!!!!!!!!!!!!!!!!!!!')
              ),
              const Text(
                'Admin', 
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      body: pages[_page],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _page,
          selectedItemColor: selectedNavBarColor,
          unselectedItemColor: unselectedNavBarColor,
          backgroundColor: backgroundColor,
          iconSize: 28,
          onTap: updatePage,
          items: [
            // HOME
            BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: _page == 0
                          ? selectedNavBarColor
                          : backgroundColor,
                      width: bottomBarBorderWidth,
                    ),
                  ),
                ),
                child: const Icon(
                  Icons.home_outlined,
                ),
              ),
              label: '',
            ),
            // ANALYTICS
            BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: _page == 1
                          ? selectedNavBarColor
                          : backgroundColor,
                      width: bottomBarBorderWidth,
                    ),
                  ),
                ),
                child: const Icon(
                  Icons.analytics_outlined,
                ),
              ),
              label: '',
            ),
            // ORDERS
            BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: _page == 2
                          ? selectedNavBarColor
                          : backgroundColor,
                      width: bottomBarBorderWidth,
                    ),
                  ),
                ),
                child: Badge(
                  elevation: 0,
                  badgeContent: const Text('2'),
                  badgeColor: Colors.white,
                  child: const Icon(
                    Icons.all_inbox_outlined,
                  ),
                ),
              ),
              label: '',
            ),
        ],
      ),
    );
  }
}