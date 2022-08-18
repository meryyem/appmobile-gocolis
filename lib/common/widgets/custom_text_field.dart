import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final Color boxColor, iconColor;
  final String hintText;
  final bool obscureText;
  final IconData icon;
  final Widget? suffixIcon;
  final int maxLines;
  final ValueChanged<String> onChanged;
  const CustomTextField(
      {Key? key,
      required this.boxColor,
      required this.iconColor,
      required this.hintText,
      required this.onChanged, required this.icon, this.suffixIcon, required this.obscureText, this.maxLines = 1, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 2),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 28),
        width: size.width * 0.8,
        height: size.height * 0.06,
        decoration: BoxDecoration(
          color: boxColor,
          borderRadius: BorderRadius.circular(29),
        ),
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          onChanged: onChanged,
          decoration: InputDecoration(
            icon: Icon(
              icon,
              color: iconColor,
            ),
            hintText: hintText,          
            border: InputBorder.none,
            suffixIcon: suffixIcon,
          ),
          maxLines: maxLines,
          validator: (val) {
            if (val == null || val.isEmpty) {
              return 'Enter your $hintText';
            }
            return null;
          },
        ),
      ),
    );
  }
}
