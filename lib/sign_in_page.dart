import 'package:flutter/material.dart';
import 'package:music_player/shared/theme.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        padding: const EdgeInsets.only(top: 110, left: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sign in",
              style: primaryColorText.copyWith(fontSize: 30),
            ),
            const SizedBox(
              height: 22,
            ),
            Text(
              "If you don’t have an account register",
              style: primaryColorText.copyWith(fontSize: 16),
            ),
            const SizedBox(
              height: 6,
            ),
            Row(
              children: [
                Text(
                  "You can   ",
                  style: primaryColorText.copyWith(fontSize: 16),
                ),
                Text(
                  "Register here!",
                  style: secondaryColorText.copyWith(
                      fontSize: 16, fontWeight: semibold),
                )
              ],
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: ListView(
          children: [header()],
        ),
      ),
    );
  }
}
