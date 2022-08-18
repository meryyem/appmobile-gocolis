import 'package:flutter/material.dart';
import 'package:gocolis/constants/colors.dart';

class AccountButton extends StatelessWidget {
  //  i will get it from a constructor
  final String text;
  final VoidCallback onTap;
  const AccountButton({Key? key, required this.text, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 0.0),
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
        ),
        child: OutlinedButton(
          style: ElevatedButton.styleFrom(
            primary: selectedNavBarColor.withOpacity(0.03),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          onPressed: onTap,
          child: Text(
            text,
            style: const TextStyle(
              color: selectedNavBarColor,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}