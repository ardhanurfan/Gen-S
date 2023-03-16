import 'package:flutter/material.dart';
import 'package:music_player/shared/theme.dart';

class CustomPopUp extends StatelessWidget {
  final String title;
  const CustomPopUp({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: backgroundColor,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'CANCEL',
              style: primaryColorText,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text(
              'ADD',
              style: primaryColorText,
            ),
          )
        ],
        title: Text(
          title,
          style: primaryColorText,
        ),
        content: TextField(
          style: primaryColorText.copyWith(fontSize: 14),
          cursorColor: primaryColor,
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(defaultRadius),
                borderSide: BorderSide(color: secondaryColor, width: 5)),
            enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(defaultRadius),
              borderSide: BorderSide(
                color: primaryColor,
                width: 3,
                style: BorderStyle.solid,
              ),
            ),
          ),
        ));
  }
}
