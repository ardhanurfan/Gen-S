import 'package:flutter/material.dart';
import 'package:music_player/shared/theme.dart';
import 'package:music_player/widgets/custom_form.dart';
import 'package:music_player/widgets/song_tile.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController search = TextEditingController();

    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(
            horizontal: defaultMargin, vertical: defaultMargin),
        children: [
          // SEARCH BAR
          TextFormField(
            controller: search,
            style: darkGreyText.copyWith(fontSize: 14),
            cursorColor: darkGreyColor,
            decoration: InputDecoration(
              hintText: "start searching",
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              fillColor: primaryColor,
              filled: true,
              hintStyle: darkGreyText.copyWith(
                fontSize: 16,
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: BorderSide(color: primaryColor, width: 5)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
                borderSide: BorderSide(
                  color: primaryColor,
                  width: 3,
                  style: BorderStyle.solid,
                ),
              ),
            ),
          ),
          //
          // Hasil Search
          //
          // EMPTY STATE
          Visibility(
            visible: false,
            child: Container(
              margin: const EdgeInsets.only(top: 90),
              child: Image.asset(
                "assets/search_empty.png",
                height: 283,
                width: 270,
              ),
            ),
          ),
          // ADA ISI
          Visibility(
              visible: true,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "History",
                        style: primaryColorText.copyWith(
                            fontSize: 20, fontWeight: bold),
                      ),
                      Text(
                        "clear",
                        style: primaryColorText.copyWith(fontSize: 12),
                      )
                    ],
                  ),
                ),
                const SongTile(
                  isSearch: true,
                )
              ]))
        ],
      );
    }

    return Scaffold(
        backgroundColor: backgroundColor, body: SafeArea(child: content()));
  }
}
