import 'package:flutter/material.dart';
import 'package:music_player/shared/theme.dart';

class LoadingButton extends StatelessWidget {
  final double heightButton;
  final double widthButton;
  final double radiusButton;
  final Color buttonColor;
  final double marginTop;
  final double marginBottom;

  const LoadingButton({
    Key? key,
    required this.radiusButton,
    required this.buttonColor,
    this.widthButton = double.infinity,
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
      child: Center(
        child: CircularProgressIndicator(
          color: primaryColor,
        ),
      ),
    );
  }
}
