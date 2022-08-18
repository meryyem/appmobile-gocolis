import 'package:flutter/material.dart';
import 'package:gocolis/constants/colors.dart';

class TopRides extends StatefulWidget {
  const TopRides({Key? key}) : super(key: key);

  @override
  State<TopRides> createState() => _TopRidesState();
}

class _TopRidesState extends State<TopRides> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
          //itemCount: GlobalVariables.categoryImages.length,
          itemCount: 3,
          scrollDirection: Axis.horizontal,
          itemExtent: 75,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {},
              //onTap: () => navigateToCategoryPage(context, GlobalVariables.categoryImages[index]['title']!),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    'Where do you want a ride to?',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: selectedNavBarColor,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal:  10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('here houna'),
                        style: ElevatedButton.styleFrom(
                        primary: unselectedNavBarColor,
                        minimumSize: const Size(double.infinity, 50),
                        ),
                      ),
                    ),
                  ),
                  // All Categories
                  GestureDetector(
                    onTap: () {},
                    child: TextButton(
                      onPressed: () {}, 
                      child: const Text(
                        'See our most popular rides',
                        //GlobalVariables.categoryImages[index]['title']!,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}