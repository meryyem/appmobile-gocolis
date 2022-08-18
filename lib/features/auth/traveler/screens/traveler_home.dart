import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:gocolis/constants/colors.dart';
import 'package:gocolis/constants/global_variables.dart';
import 'package:gocolis/features/auth/sender/screens/delivery_requests_screen.dart';
import 'package:gocolis/features/auth/traveler/screens/ride_request.dart';
import 'package:gocolis/features/profile/screens/profile_screen.dart';

class TravelerHome extends StatefulWidget {
  static const String routeName = '/traveler-home';
  const TravelerHome({Key? key}) : super(key: key);

  @override
  State<TravelerHome> createState() => _TravelerHomeState();
}

class _TravelerHomeState extends State<TravelerHome> {
  int _page = 0;
  double TravelerHomeWidth = 42;
  double TravelerHomeBorderWidth = 5;

  List<Widget> pages = [
    //const MainProfile(),
    const RideRequestScreen(),
    const Center(child: Text('ProfileScreen')),
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
                'Traveler', 
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
              width: TravelerHomeWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 0
                        ? selectedNavBarColor
                        : backgroundColor,
                    width: TravelerHomeBorderWidth,
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
              width: TravelerHomeWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 0
                        ? selectedNavBarColor
                        : backgroundColor,
                    width: TravelerHomeBorderWidth,
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
              width: TravelerHomeWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 1
                        ? selectedNavBarColor
                        : backgroundColor,
                    width: TravelerHomeBorderWidth,
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
              width: TravelerHomeWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 2
                        ? selectedNavBarColor
                        : backgroundColor,
                    width: TravelerHomeBorderWidth,
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
