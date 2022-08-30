import 'package:flutter/material.dart';
import 'package:gocolis/constants/colors.dart';


class ButtonCard extends StatelessWidget {
  const ButtonCard({Key? key, required this.name, required this.icon,}) : super(key: key);
  final String name;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 23,
        backgroundColor: kPrimaryColor,
        child: Icon(icon, size: 26, color: kPrimaryLightColor,)
      ),
      title: Text(name,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
    );
  }
}
