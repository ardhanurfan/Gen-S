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
      backgroundColor: backgroundColor,
      actions: [
        Visibility(
          visible: !isLoading,
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'CANCEL',
              style: primaryColorText,
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
              style: primaryColorText,
            ),
          ),
        )
      ],
      title: Visibility(
        visible: !isLoading,
        child: Text(
          widget.title,
          style: primaryColorText,
        ),
      ),
      content: isLoading
          ? SizedBox(
              width: 30,
              height: 30,
              child: Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: primaryColor,
                  size: 32,
                ),
              ),
            )
          : TextField(
              controller: widget.controller,
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
            ),
    );
  }
}
