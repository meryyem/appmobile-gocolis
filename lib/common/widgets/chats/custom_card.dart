import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gocolis/constants/colors.dart';
import 'package:gocolis/features/messages/screens/individual_page.dart';
import 'package:gocolis/models/chat.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.chat, required this.sourceChat,
  }) : super(key: key);
  final Chat chat;
  final Chat sourceChat;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => IndividualPage(chat: chat,  sourceChat: sourceChat)));
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: kPrimaryLightColor,
              child: SvgPicture.asset(
                chat.isGroup
                    ? "assets/icons/groups.svg"
                    : "assets/icons/person.svg",
                color: Colors.white,
                height: 37,
                width: 37,
              ),
            ),
            trailing: Text(chat.time!),
            title: Text(chat.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )),
            subtitle: Row(children: [
              const Icon(Icons.done_all),
              const SizedBox(
                width: 3,
              ),
              Text(
                chat.currentMessage!,
                style: const TextStyle(
                  fontSize: 13,
                  //fontWeight: FontWeight.bold,
                ),
              ),
            ]),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 20, left: 80),
            child: Divider(thickness: 1),
          ),
        ],
      ),
    );
  }
}
