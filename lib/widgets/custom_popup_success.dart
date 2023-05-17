import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_player/providers/user_provider.dart';
import 'package:music_player/shared/theme.dart';
import 'package:provider/provider.dart';

class CustomPopUpSuccess extends StatefulWidget {
  final String title;
  final Function() add;
  const CustomPopUpSuccess({
    super.key,
    required this.title,
    required this.add,
  });

  @override
  State<CustomPopUpSuccess> createState() => _CustomPopUpSuccessState();
}

bool isLoading = false;

class _CustomPopUpSuccessState extends State<CustomPopUpSuccess> {
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
                'YES',
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
            : Text(
                "Do you want to add this audio?",
                style: userProvider.user.role == "USER"
                    ? primaryUserColorText
                    : primaryAdminColorText,
              ));
  }
}
