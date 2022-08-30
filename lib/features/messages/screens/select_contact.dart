import 'package:flutter/material.dart';
import 'package:gocolis/common/widgets/chats/button_card.dart';
import 'package:gocolis/common/widgets/chats/contact_card.dart';
import 'package:gocolis/features/messages/screens/create_group.dart';
import 'package:gocolis/models/chat.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({Key? key}) : super(key: key);

  @override
  State<SelectContact> createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  @override
  Widget build(BuildContext context) {
    List<Chat> chats = [
      Chat(
        name: "Maryem",
        status: "maryem",
        isGroup: false,
        id: 0,
      ),
      Chat(
        name: "Maryem",
        status: "maryem",
        isGroup: false,
        id: 0,
      ),
      Chat(
        name: "Maryem",
        status: "maryem",
        isGroup: false,
        id: 0,
      ),
      Chat(
        name: "Maryem",
        status: "maryem",
        isGroup: false,
        id: 0,
      ),
      Chat(
        name: "Maryem",
        status: "maryem",
        isGroup: false,
        id: 0,
      ),
      Chat(
        name: "Maryem",
        status: "maryem",
        isGroup: false,
        id: 0,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Column(children: const [
          Text(
            "Select Contact",
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "256 Contacts",
            style: TextStyle(
              fontSize: 13,
            ),
          ),
        ]),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, size: 26),
          ),
          PopupMenuButton<String>(onSelected: (value) {
            print(value);
          }, itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(
                value: "Invite a friend",
                child: Text("Invite a friend"),
              ),
              const PopupMenuItem(
                value: "Contacts",
                child: Text("Contacts"),
              ),
              const PopupMenuItem(
                value: "Refresh",
                child: Text("Refresh"),
              ),
              const PopupMenuItem(
                value: "Help",
                child: Text("Help"),
              ),
            ];
          }),
        ],
      ),
      body: ListView.builder(
          itemCount: chats.length + 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (builder) => CreateGroup()));
                },
                child: const ButtonCard(icon: Icons.groups, name: "New Group"),
              );
            } else if (index == 1) {
              return const ButtonCard(
                  icon: Icons.person_add, name: "New Contact");
            }
            return ContactCard(
              contact: chats[index - 2],
            );
          }),
    );
  }
}
