import 'package:flutter/material.dart';
import 'package:gocolis/common/widgets/chats/avatar_card.dart';
import 'package:gocolis/common/widgets/chats/button_card.dart';
import 'package:gocolis/common/widgets/chats/contact_card.dart';
import 'package:gocolis/constants/colors.dart';
import 'package:gocolis/models/chat.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({Key? key}) : super(key: key);

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
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

  List<Chat> groups = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(children: const [
          Text(
            "New Group",
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Add Participants",
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
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
              itemCount: chats.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Container(
                    height: groups.length > 0 ? 90 : 10,
                  );
                }
                return InkWell(
                  /*onTap: () {
                    if (chats[index].select == false) {
                      setState(() {
                        chats[index].select = true;
                        groups.add(chats[index]);
                      });
                    } else {
                      setState(() {
                        chats[index].select = false;
                        groups.remove(chats[index]);
                      });
                    }
                  },*/
                  onTap: () {
                    setState(() {
                      if (chats[index - 1].select == true) {
                        groups.add(chats[index - 1]);
                        chats[index - 1].select = false;
                        
                    } else {
                      setState(() {
                        groups.remove(chats[index - 1]);
                        chats[index - 1].select = true;
                       
                      });
                    }
                    });
                  },
                  child: ContactCard(
                    contact: chats[index - 1],
                  ),
                );
              }),
          groups.length > 0 ? Column(
            children: [
              Container(
                height: 75,
                color: kPrimaryColor,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: chats.length,
                    itemBuilder: (context, index) {
                      if (chats[index].select == true) {
                        return InkWell(
                            onTap: () {
                              setState(() {
                                groups.remove(chats[index]);
                                chats[index].select = false;
                              });
                            },
                            child: AvatarCard(contact: chats[index]));
                      } else {
                        return Container();
                      }
                    }),
              ),
              const Divider(
                thickness: 1,
              ),
            ],
          ) : Container(),
        ],
      ),
    );
  }
}
