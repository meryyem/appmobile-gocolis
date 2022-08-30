import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gocolis/constants/colors.dart';
import 'package:gocolis/models/chat.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({Key? key, required this.contact}) : super(key: key);
  final Chat contact;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 53,
        width: 50,
        child: Stack(
          children: [
            CircleAvatar(
            radius: 23,
            backgroundColor: kPrimaryColor,
            child: SvgPicture.asset("assets/icons/person.svg",
                color: Colors.white, height: 30, width: 30),
            ),
            contact.select ? const Positioned(
              bottom: 4,
              right: 5,
              child: CircleAvatar(
                radius: 11,
                backgroundColor: kPrimaryLightColor,
                child: Icon(
                  Icons.check,
                  color: kPrimaryColor,
                  size: 18,
                ),
              ),
            )
            : Container(),
          ]
          
          
        ),
      ),
      title: Text(contact.name,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
      subtitle: Text(contact.status!,
          style: const TextStyle(
            fontSize: 13,
          )),
    );
  }
}
