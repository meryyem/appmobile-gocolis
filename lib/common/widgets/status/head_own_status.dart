import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class HeadOwnStatus extends StatelessWidget {
  const HeadOwnStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(
        children: const [
          CircleAvatar(
            radius: 27,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage("assets/images/profile.png"),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              backgroundColor: kPrimaryColor,
              radius: 10,
              child: Icon(Icons.add, size: 20, color: Colors.white),
            ),
          ),
        ],
      ),
      title: const Text(
        "My Status",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        "Tap to add status update",
        style: TextStyle(
          fontSize: 13,
          //fontWeight: FontWeight.bold,
          color: Colors.grey[900],
        ),
      ),
    );
  }
}
