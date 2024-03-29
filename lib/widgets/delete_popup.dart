import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_player/shared/theme.dart';

class DeletePopUp extends StatefulWidget {
  final Function() delete;
  const DeletePopUp({
    super.key,
    required this.delete,
  });

  @override
  State<DeletePopUp> createState() => _DeletePopUpState();
}

bool isLoading = false;

class _DeletePopUpState extends State<DeletePopUp> {
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
              await widget.delete();
              navigator.pop(true);
              setState(() {
                isLoading = false;
              });
            },
            child: Text(
              'YES',
              style: primaryUserColorText,
            ),
          ),
        )
      ],
      title: Visibility(
        visible: !isLoading,
        child: Text(
          'Are you sure?',
          style: primaryUserColorText,
        ),
      ),
      content: Visibility(
        visible: isLoading,
        child: SizedBox(
          width: 30,
          height: 30,
          child: Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: primaryUserColor,
              size: 32,
            ),
          ),
        ),
      ),
    );
  }
}
