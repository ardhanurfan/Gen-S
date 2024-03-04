import 'package:flutter/material.dart';
import 'package:music_player/shared/theme.dart';

class PopUpNotLoggedIn extends StatelessWidget {
  const PopUpNotLoggedIn({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backgroundUserColor,
      title: Text(
        "Failed",
        style: primaryUserColorText,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('CLOSE', style: primaryUserColorText),
        ),
      ],
      content: Text(
        "You're not logged in :(\nPlease login and try again",
        style: primaryUserColorText,
      ),
    );
  }
}
