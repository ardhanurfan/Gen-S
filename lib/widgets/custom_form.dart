import 'package:flutter/material.dart';

import '../shared/theme.dart';

class CustomForm extends StatelessWidget {
  const CustomForm({
    Key? key,
    required this.title,
    required this.textController,
    required this.prefixIcon,
    required this.hintText,
    this.isPassword = false,
  }) : super(key: key);

  final String title;
  final TextEditingController textController;
  final IconData prefixIcon;
  final String hintText;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 42),
          child: Text(
            title,
            style: primaryColorText.copyWith(fontSize: 13, fontWeight: medium),
          ),
        ),
        const SizedBox(height: 3),
        TextFormField(
          controller: textController,
          obscureText: isPassword,
          style: primaryColorText.copyWith(fontSize: 13),
          cursorColor: primaryColor,
          decoration: InputDecoration(
            suffixIcon: Visibility(
              visible: isPassword,
              child: Icon(
                Icons.visibility_off,
                color: primaryColor,
              ),
            ),
            prefixIcon: Icon(
              prefixIcon,
              color: primaryColor,
              size: 21,
            ),
            hintText: hintText,
            hintStyle: primaryColorText.copyWith(fontSize: 16),
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
      ],
    );
  }
}
