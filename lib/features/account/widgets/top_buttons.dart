import 'package:flutter/material.dart';
import 'package:gocolis/features/account/widgets/account_button.dart';

class TopButton extends StatefulWidget {
  TopButton({Key? key}) : super(key: key);

  @override
  State<TopButton> createState() => _TopButtonState();
}

class _TopButtonState extends State<TopButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              text: 'Your Orders', 
              onTap: () {},
            ),
            AccountButton(
              text: 'Turn Seller', 
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            AccountButton(
              text: 'Log Out', 
              onTap: () {},
            ),
            AccountButton(
              text: 'Your Wish List', 
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}