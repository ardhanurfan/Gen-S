import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_player/providers/images_provider.dart';
import 'package:music_player/providers/user_provider.dart';
import 'package:music_player/shared/theme.dart';
import 'package:provider/provider.dart';

class ImagePopUp extends StatefulWidget {
  final Function() add;
  const ImagePopUp({super.key, required this.add});

  @override
  State<ImagePopUp> createState() => _ImagePopUpState();
}

bool isLoading = false;

class _ImagePopUpState extends State<ImagePopUp> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    ImagesProvider imagesProvider = Provider.of<ImagesProvider>(context);

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
          "Image Preview",
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
          : Image.file(
              imagesProvider.croppedImageFile!,
              width: 220,
              height: 220,
              fit: BoxFit.cover,
            ),
    );
  }
}
