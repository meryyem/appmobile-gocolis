import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class ReplyCard extends StatelessWidget {
  final String replyMessage;
  final String time;
  const ReplyCard({Key? key, required this.replyMessage, required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),),
          color: kPrimaryLightColor,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child:  Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 60,
                  top: 10,
                  bottom: 20,
                ),
                child: Text(
                  replyMessage, 
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Text(
                  time,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
