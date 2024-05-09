import 'package:flutter/material.dart';
import 'package:music_player/shared/theme.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

class EmptyStatePage extends StatelessWidget {
  const EmptyStatePage({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    Widget mainIcon() {
      return Container(
        margin: const EdgeInsets.only(top: 80),
        height: 260,
        width: 340,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/empty_state.png"),
                fit: BoxFit.contain)),
      );
    }

    Widget mainText() {
      return Center(
        child: Container(
          margin: const EdgeInsets.only(top: 49, bottom: 8),
          child: Text(
            userProvider.user != null
                ? "Your library is empty  :("
                : "Your audio history is off",
            textAlign: TextAlign.center,
            style: userProvider.user?.role == "USER" ||
                    userProvider.user == null
                ? primaryUserColorText.copyWith(fontSize: 24, fontWeight: bold)
                : primaryAdminColorText.copyWith(
                    fontSize: 24, fontWeight: bold),
          ),
        ),
      );
    }

    Widget secondaryText() {
      return Visibility(
        visible: userProvider.user == null,
        child: Center(
          child: Text(
            "Please login to use history feature",
            textAlign: TextAlign.center,
            style: userProvider.user?.role == "USER" ||
                    userProvider.user == null
                ? primaryUserColorText.copyWith(fontSize: 14, fontWeight: bold)
                : primaryAdminColorText.copyWith(
                    fontSize: 14, fontWeight: bold),
          ),
        ),
      );
    }

    return Expanded(
      child: ListView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: [mainIcon(), mainText(), secondaryText()],
      ),
    );
  }
}
