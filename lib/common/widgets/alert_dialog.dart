import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String text;
  final Function()? onTap;
  const CustomAlertDialog({Key? key, required this.text, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children : [
          AlertDialog(
            title: const Text('GoColis'),
            content: Text(text),
          ),
          TextButton(
            child: Text('ok'),
            onPressed: onTap,
          ),
        ],
      ),
    );
  }
}
