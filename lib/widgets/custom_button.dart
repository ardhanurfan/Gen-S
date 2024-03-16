import 'package:flutter/material.dart';
import 'package:music_player/shared/theme.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Function() onPressed;
  final double heightButton;
  final double widthButton;
  final double radiusButton;
  final Color buttonColor;
  final double marginTop;
  final double marginBottom;

  const CustomButton({
    Key? key,
    required this.radiusButton,
    required this.buttonColor,
    required this.buttonText,
    this.widthButton = double.infinity,
    required this.onPressed,
    required this.heightButton,
    this.marginTop = 0,
    this.marginBottom = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: marginTop, bottom: marginBottom),
      width: widthButton,
      height: heightButton,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radiusButton))),
        child: Text(buttonText,
            style: buttonColor == primaryUserColor
                ? primaryAdminColorText.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  )
                : primaryUserColorText.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  )),
      ),
    );
  }
}
