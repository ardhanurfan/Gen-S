import 'package:flutter/material.dart';
import 'package:music_player/pages/pages_user/empty_album_page.dart';
import 'package:music_player/shared/theme.dart';
import 'package:music_player/widgets/custom_button.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.arrow_back_rounded,
            color: primaryColor,
          ),
          Expanded(
            child: Text(
              "Album Name",
              textAlign: TextAlign.end,
              style: primaryColorText.copyWith(fontSize: 20, fontWeight: bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.all(defaultMargin),
        children: [header(), EmptyAlbumPage()],
      );
    }

    return Scaffold(
        backgroundColor: backgroundColor, body: SafeArea(child: content()));
  }
}
