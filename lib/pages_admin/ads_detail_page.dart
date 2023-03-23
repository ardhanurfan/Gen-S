import 'package:flutter/material.dart';

import '../shared/theme.dart';

class AdsDetailPage extends StatelessWidget {
  const AdsDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController(text: "");
    Widget header() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: primaryAdminColor,
            ),
          ),
          Text(
            "Edit Ads",
            style:
                primaryAdminColorText.copyWith(fontSize: 24, fontWeight: bold),
          )
        ],
      );
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(
            horizontal: defaultMargin, vertical: defaultMargin),
        children: [
          header(),
          Padding(
            padding:
                const EdgeInsets.only(top: 60, left: 50, right: 50, bottom: 30),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                "assets/ex_gallery.png",
                height: 220,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Text(
            "Title",
            style: primaryAdminColorText.copyWith(
                fontSize: 14, fontWeight: medium),
          ),
          const SizedBox(
            height: 3,
          ),
          TextFormField(
            controller: titleController,
            style: primaryAdminColorText.copyWith(fontSize: 14),
            cursorColor: primaryAdminColor,
            decoration: InputDecoration(
              hintStyle: primaryAdminColorText.copyWith(fontSize: 16),
              focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(defaultRadius),
                  borderSide: BorderSide(color: secondaryColor, width: 5)),
              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(defaultRadius),
                borderSide: BorderSide(
                  color: primaryAdminColor,
                  width: 3,
                  style: BorderStyle.solid,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Set time",
            style: primaryAdminColorText,
          ),
          TimePickerDialog(
            initialTime: TimeOfDay.now(),
          )
        ],
      );
    }

    return Scaffold(
      body: SafeArea(child: content()),
    );
  }
}
