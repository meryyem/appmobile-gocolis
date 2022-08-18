import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gocolis/constants/colors.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: size.width * 0.8,
          child: Stack(alignment: Alignment.center, children: const [
             Divider(
                color: kPrimaryColor,
                height: 1.5,
            ),
            Text(
              "OR",
              style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.w600,
                backgroundColor: Colors.white,
              ),
            ),
          ]),
        ),
        SizedBox(height: size.height * 0.05),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: kPrimaryColor,
                  ),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset("assets/icons/facebook.svg", height: 20, width: 20, color: kPrimaryColor),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: kPrimaryColor,
                  ),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  "assets/icons/google-plus.svg", 
                  height: 20, 
                  width: 20, 
                  color: kPrimaryColor
                ),
              ),
            ),
          ],
        ),
      ], 
    );
  }
}
