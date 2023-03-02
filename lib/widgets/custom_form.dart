import 'package:flutter/material.dart';

import '../shared/theme.dart';

class CustomForm extends StatefulWidget {
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
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 42),
          child: Text(
            widget.title,
            style: primaryColorText.copyWith(fontSize: 14, fontWeight: medium),
          ),
        ),
        const SizedBox(height: 3),
        TextFormField(
          controller: widget.textController,
          obscureText: widget.isPassword ? isObscure : false,
          style: primaryColorText.copyWith(fontSize: 14),
          cursorColor: primaryColor,
          decoration: InputDecoration(
            suffixIcon: Visibility(
              visible: widget.isPassword,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                child: Icon(
                  isObscure ? Icons.visibility_off : Icons.visibility,
                  color: primaryColor,
                ),
              ),
            ),
            prefixIcon: Icon(
              widget.prefixIcon,
              color: primaryColor,
              size: 21,
            ),
            hintText: widget.hintText,
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
