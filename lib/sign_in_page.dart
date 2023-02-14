import 'package:flutter/material.dart';
import 'package:music_player/shared/theme.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController =
        TextEditingController(text: '');
    final TextEditingController passwordController =
        TextEditingController(text: '');
    Widget header() {
      return Container(
        padding: EdgeInsets.only(top: 110, left: defaultMargin),
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

    Widget inputEmail() {
      return Container(
          margin: const EdgeInsets.only(top: 3),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: TextFormField(
            controller: emailController,
            style: primaryColorText.copyWith(fontSize: 13),
            cursorColor: primaryColor,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: primaryColor,
                  size: 21,
                ),
                hintText: "Enter your email address",
                hintStyle: primaryColorText.copyWith(fontSize: 16),
                focusedBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    borderSide: BorderSide(color: primaryColor, width: 5)),
                enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    borderSide: BorderSide(
                      color: primaryColor,
                      width: 3,
                      style: BorderStyle.solid,
                    ))),
          ));
    }

    Widget inputPassword() {
      return Container(
          margin: const EdgeInsets.only(top: 3),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: TextFormField(
            controller: passwordController,
            obscureText: true,
            style: primaryColorText.copyWith(fontSize: 13),
            cursorColor: primaryColor,
            decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.visibility_off,
                  color: primaryColor,
                ),
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: primaryColor,
                  size: 21,
                ),
                hintText: "Enter your email address",
                hintStyle: primaryColorText.copyWith(fontSize: 16),
                focusedBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    borderSide: BorderSide(color: primaryColor, width: 5)),
                enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    borderSide: BorderSide(
                      color: primaryColor,
                      width: 3,
                      style: BorderStyle.solid,
                    ))),
          ));
    }

    Widget forgotPassword() {
      return Container(
        padding: const EdgeInsets.only(right: 31),
        margin: const EdgeInsets.only(top: 8),
        child: GestureDetector(
            onTap: () {},
            child: Text(
              "Forgot Password?",
              style: greyColorText,
            )),
      );
    }

    Widget content() {
      return ListView(
        children: [
          header(),
          Container(
              padding: EdgeInsets.only(left: defaultMargin),
              margin: const EdgeInsets.only(top: 52),
              child: Text(
                "Email",
                style:
                    primaryColorText.copyWith(fontSize: 13, fontWeight: medium),
              )),
          inputEmail(),
          Container(
              padding: EdgeInsets.only(left: defaultMargin),
              margin: const EdgeInsets.only(top: 49),
              child: Text(
                "Password",
                style:
                    primaryColorText.copyWith(fontSize: 13, fontWeight: medium),
              )),
          inputPassword(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              forgotPassword(),
            ],
          )
        ],
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(child: content()),
    );
  }
}
