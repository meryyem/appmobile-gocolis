import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color color, textColor, boxColor;
  final VoidCallback onPressed;
  const CustomButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.color,
      required this.textColor, required this.boxColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 2),
          width: size.width * 0.8,
          height: size.height * 0.06,
          decoration: BoxDecoration(
            color: boxColor,
            borderRadius: BorderRadius.circular(29),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(35.0),
            child: ElevatedButton(
              child: Text(
                text,
                style: TextStyle(
                  color: textColor,
                ),
              ),
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                primary: color,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ),
        ));

    /*Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      //margin: const EdgeInsets.symmetric(vertical: 10),
      //padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ClipRRect(
        
        borderRadius: BorderRadius.circular(35.0),
        child: Container(
          width: size.width * 0.84,
          height: size.height * 0.060,
          
        ),
        ),
      );*/
  }
}
