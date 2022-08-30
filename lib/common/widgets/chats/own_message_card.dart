import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class OwnMessageCard extends StatelessWidget {
  final String ownMessage;
  final String time;
  const OwnMessageCard({Key? key, required this.ownMessage, required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          color: kPrimaryColor,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 60,
                  top: 10,
                  bottom: 20,
                ),
                child: Text(
                  ownMessage,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Row(children: [
                  Text(time,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      )),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    Icons.done_all,
                    size: 20,
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
