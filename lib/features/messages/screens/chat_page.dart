import 'package:flutter/material.dart';
import 'package:gocolis/common/widgets/chats/custom_card.dart';
import 'package:gocolis/features/messages/screens/select_contact.dart';
import 'package:gocolis/models/chat.dart';

class ChatPage extends StatefulWidget {
  final List<Chat> chats;
  final Chat sourceChat;
  const ChatPage({Key? key, required this.chats, required this.sourceChat}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (builder) => const SelectContact()));
          },
          child: const Icon(Icons.chat)),
      body: ListView.builder(
        itemCount: widget.chats.length,
        itemBuilder: (context, index) => CustomCard(
          chat: widget.chats[index],
          sourceChat: widget.sourceChat,
        ),
      ),
    );
  }
}
