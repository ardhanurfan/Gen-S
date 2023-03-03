import 'package:flutter/material.dart';
import 'package:music_player/shared/theme.dart';
import 'package:music_player/widgets/custom_button.dart';

class CreatePlaylistPage extends StatelessWidget {
  const CreatePlaylistPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController title = TextEditingController();
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
              color: primaryColor,
            ),
          ),
          Text(
            "New Playlist",
            style: primaryColorText.copyWith(fontSize: 20, fontWeight: bold),
          )
        ],
      );
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.all(defaultMargin),
        children: [
          header(),
          // IMAGE
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 63,
                ),
                height: 200,
                width: 200,
                color: primaryColor,
                child: Center(
                  child: Text(
                    "Add Image",
                    textAlign: TextAlign.center,
                    style:
                        darkGreyText.copyWith(fontSize: 12, fontWeight: bold),
                  ),
                ),
              ),
            ],
          ),
          //TITLE
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: TextFormField(
              controller: title,
              textAlign: TextAlign.center,
              style: primaryColorText.copyWith(fontSize: 14),
              cursorColor: primaryColor,
              decoration: InputDecoration(
                hintText: "Playlist Name",
                hintStyle: primaryColorText.copyWith(
                  fontSize: 16,
                ),
                focusedBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    borderSide: BorderSide(
                      color: secondaryColor,
                    )),
                enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(defaultRadius),
                  borderSide: BorderSide(
                    color: primaryColor,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ),
          ),
          //
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 16),
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: addSongsColor),
                    child: Icon(
                      Icons.add,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Add Songs",
                    style: primaryColorText.copyWith(
                        fontSize: 12, fontWeight: bold),
                  )
                ],
              ),
            ),
          ),
        ],
      );
    }

    Widget createPlaylistButton() {
      return Container(
        margin: EdgeInsets.only(
            right: defaultMargin, bottom: 40, left: defaultMargin, top: 16),
        child: CustomButton(
            radiusButton: 32,
            buttonColor: secondaryColor,
            buttonText: "Create Playlist",
            onPressed: () {},
            heightButton: 53),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
          child: Column(
        children: [Expanded(child: content()), createPlaylistButton()],
      )),
    );
  }
}
