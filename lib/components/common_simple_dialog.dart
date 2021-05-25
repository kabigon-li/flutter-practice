import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wechat_like_memo/constant/constants.dart';

class CommonSimpleDialog extends StatelessWidget {
  CommonSimpleDialog({
    this.title,
    this.onPressed,
  });

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // title: Text("タイトル")
      content: Text(
        title,
        style: TextStyle(fontSize: 14),
      ),
      actions: <Widget>[
        // ボタン領域
        ElevatedButton(
          child: Text("Cancel"),
          style: ElevatedButton.styleFrom(
            primary: Colors.black12,
          ),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        ElevatedButton(
          child: Text("Delete"),
          style: ElevatedButton.styleFrom(
            primary: buttonColor,
          ),
          onPressed: onPressed,
        ),
      ],
    );
  }
}
