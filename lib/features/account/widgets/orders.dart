import 'package:flutter/material.dart';
import 'package:gocolis/constants/colors.dart';
import 'package:gocolis/features/account/widgets/single_item.dart';


class Orders extends StatefulWidget {
  Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  //TEMPORARY LIST
  List list = [
    'https://www.pinterest.com/pin/603200943833017603/',
    'https://www.pinterest.com/pin/603200943833017603/',
    'https://www.pinterest.com/pin/603200943833017603/',
    'https://www.pinterest.com/pin/603200943833017603/',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 15,
              ),
              child: const Text(
                'Your Orders',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                right: 15,
              ),
              child: const Text(
                'See all',
                style: TextStyle(
                  color: selectedNavBarColor,
                ),
              ),
            ),
          ],
        ),
        // DISPLAY ORDERS
        Container(
          height: 170,
          padding: const EdgeInsets.only(
            left: 10,
            top: 20,
            right: 0,
          ),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return SingleItem(
                  image: list[index],
                );
              }),
        ),
      ],
    );
  }
}