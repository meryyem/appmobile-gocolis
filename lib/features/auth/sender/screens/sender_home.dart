import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:gocolis/constants/colors.dart';
import 'package:gocolis/constants/global_variables.dart';
import 'package:gocolis/features/auth/sender/screens/delivery_requests_screen.dart';
import 'package:gocolis/features/profile/screens/profile_screen.dart';

class SenderHome extends StatefulWidget {
  static const String routeName = '/sender-home';
  const SenderHome({Key? key}) : super(key: key);

  @override
  State<SenderHome> createState() => _SenderHomeState();
}

class _SenderHomeState extends State<SenderHome> {
  int _page = 0;
  double SenderHomeWidth = 42;
  double SenderHomeBorderWidth = 5;

  List<Widget> pages = [
    //const MainProfile(),
    const DeliveryRequestsScreen(),
    const ProfileScreen(),
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
                child: Text('GoColis')
              ),
              const Text(
                'Sender', 
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
        backgroundColor: Colors.white,
        iconSize: 28,
        onTap: updatePage,
        items: [
          // PROFILE
          /*BottomNavigationBarItem(
            icon: Container(
              width: SenderHomeWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 0
                        ? selectedNavBarColor
                        : backgroundColor,
                    width: SenderHomeBorderWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.home_outlined,
              ),
            ),
            label: '',
          ),*/
          // HOME
          BottomNavigationBarItem(
            icon: Container(
              width: SenderHomeWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 0
                        ? selectedNavBarColor
                        : backgroundColor,
                    width: SenderHomeBorderWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.home_outlined,
              ),
            ),
            label: '',
          ),
          // ACCOUNT
          BottomNavigationBarItem(
            icon: Container(
              width: SenderHomeWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 1
                        ? selectedNavBarColor
                        : backgroundColor,
                    width: SenderHomeBorderWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.person_outlined,
              ),
            ),
            label: '',
          ),
          // CART
          BottomNavigationBarItem(
            icon: Container(
              width: SenderHomeWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 2
                        ? selectedNavBarColor
                        : backgroundColor,
                    width: SenderHomeBorderWidth,
                  ),
                ),
              ),
              child: Badge(
                elevation: 0,
                badgeContent: const Text('2'),
                badgeColor: Colors.white,
                child: const Icon(
                  Icons.shopping_cart_outlined,
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
