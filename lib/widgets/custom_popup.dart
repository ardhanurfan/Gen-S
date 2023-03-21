import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_player/shared/theme.dart';

class CustomPopUp extends StatefulWidget {
  final String title;
  final Function() add;
  final TextEditingController controller;
  const CustomPopUp(
      {super.key,
      required this.title,
      required this.add,
      required this.controller});

  @override
  State<CustomPopUp> createState() => _CustomPopUpState();
}

bool isLoading = false;

class _CustomPopUpState extends State<CustomPopUp> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backgroundUserColor,
      actions: [
        Visibility(
          visible: !isLoading,
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'CANCEL',
              style: primaryUserColorText,
            ),
          ),
        ),
        Visibility(
          visible: !isLoading,
          child: TextButton(
            onPressed: () async {
              setState(() {
                isLoading = true;
              });
              final navigator = Navigator.of(context);
              await widget.add();
              navigator.pop(true);
              setState(() {
                isLoading = false;
              });
            },
            child: Text(
              'SAVE',
              style: primaryUserColorText,
            ),
          ),
        )
      ],
      title: Visibility(
        visible: !isLoading,
        child: Text(
          widget.title,
          style: primaryUserColorText,
        ),
      ),
      content: isLoading
          ? SizedBox(
              width: 30,
              height: 30,
              child: Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: primaryUserColor,
                  size: 32,
                ),
              ),
            )
          : TextField(
              controller: widget.controller,
              style: primaryUserColorText.copyWith(fontSize: 14),
              cursorColor: primaryUserColor,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    borderSide: BorderSide(color: secondaryColor, width: 5)),
                enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(defaultRadius),
                  borderSide: BorderSide(
                    color: primaryUserColor,
                    width: 3,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ),
    );
  }
}
