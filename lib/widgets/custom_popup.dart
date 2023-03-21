import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_player/providers/user_provider.dart';
import 'package:music_player/shared/theme.dart';
import 'package:provider/provider.dart';

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
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return AlertDialog(
      backgroundColor: userProvider.user.role == "USER"
          ? backgroundUserColor
          : const Color.fromARGB(255, 224, 224, 224),
      actions: [
        Visibility(
          visible: !isLoading,
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'CANCEL',
              style: userProvider.user.role == "USER"
                  ? primaryUserColorText
                  : primaryAdminColorText,
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
              style: userProvider.user.role == "USER"
                  ? primaryUserColorText
                  : primaryAdminColorText,
            ),
          ),
        )
      ],
      title: Visibility(
        visible: !isLoading,
        child: Text(
          widget.title,
          style: userProvider.user.role == "USER"
              ? primaryUserColorText
              : primaryAdminColorText,
        ),
      ),
      content: isLoading
          ? SizedBox(
              width: 30,
              height: 30,
              child: Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: userProvider.user.role == "USER"
                      ? primaryUserColor
                      : primaryAdminColor,
                  size: 32,
                ),
              ),
            )
          : TextField(
              controller: widget.controller,
              style: userProvider.user.role == "USER"
                  ? primaryUserColorText.copyWith(fontSize: 14)
                  : primaryAdminColorText.copyWith(fontSize: 14),
              cursorColor: userProvider.user.role == "USER"
                  ? primaryUserColor
                  : primaryAdminColor,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    borderSide: BorderSide(color: secondaryColor, width: 5)),
                enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(defaultRadius),
                  borderSide: BorderSide(
                    color: userProvider.user.role == "USER"
                        ? primaryUserColor
                        : primaryAdminColor,
                    width: 3,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ),
    );
  }
}
