import 'package:flutter/material.dart';
import 'package:gocolis/common/widgets/chats/button_card.dart';
import 'package:gocolis/features/messages/screens/message_home.dart';
import 'package:gocolis/models/chat.dart';

class ChatLoginScreen extends StatefulWidget {
  final Function onTap;
  final Function onImageSend;
  const ChatLoginScreen({
    Key? key,
    required this.onTap, required this.onImageSend,
  }) : super(key: key);

  @override
  State<ChatLoginScreen> createState() => _ChatLoginScreenState();
}

class _ChatLoginScreenState extends State<ChatLoginScreen> {
  Chat? sourceChat;
  List<Chat> chats = [
    Chat(
      name: 'Maryem',
      isGroup: false,
      currentMessage: "Hi Maryem",
      time: "4:00",
      icon: "person.svg",
      id: 1,
    ),
    Chat(
      name: 'Sakly',
      isGroup: false,
      currentMessage: "Hi Sakly",
      time: "10:00",
      icon: "person.svg",
      id: 2,
    ),
    Chat(
      name: 'Maryem Sakly',
      isGroup: false,
      currentMessage: "Hi Sakly",
      time: "10:00",
      icon: "person.svg",
      id: 3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: chats.length,
          itemBuilder: (context, index) => InkWell(
                onTap: () {
                  // i will put the sender person in the sourceChat variable and remove
                  // it from the list of chats
                  sourceChat = chats.removeAt(index);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => MessageHome(
                                chats: chats,
                                sourceChat: sourceChat!,
                                onImageSend: widget.onImageSend,
                              )));
                },
                child: ButtonCard(
                  name: chats[index].name,
                  icon: Icons.person,
                ),
              )),
    );
  }
}
