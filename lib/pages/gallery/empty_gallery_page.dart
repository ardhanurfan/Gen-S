import 'package:flutter/material.dart';
import 'package:music_player/providers/user_provider.dart';
import 'package:music_player/shared/theme.dart';
import 'package:provider/provider.dart';

class EmptyGalleryPage extends StatelessWidget {
  const EmptyGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return ListView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      children: [
        Container(
          margin: const EdgeInsets.only(top: 120, bottom: 70),
          child: Image.asset(
            "assets/empty_gallery.png",
            width: 345,
            height: 184,
          ),
        ),
        Text(
          "Nothing pictures here :(",
          textAlign: TextAlign.center,
          style: userProvider.user?.role == "USER" || userProvider.user == null
              ? primaryUserColorText.copyWith(fontSize: 20, fontWeight: bold)
              : primaryAdminColorText.copyWith(fontSize: 20, fontWeight: bold),
        ),
      ],
    );
  }
}
