import 'package:flutter/material.dart';
import 'package:music_player/shared/theme.dart';
import 'package:music_player/widgets/custom_button.dart';

import '../widgets/custom_form.dart';

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
        margin: const EdgeInsets.only(top: 110),
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
                GestureDetector(
                  onTap: () => Navigator.pushNamedAndRemoveUntil(
                      context, '/sign-up', (route) => false),
                  child: Text(
                    "Register here!",
                    style: secondaryColorText.copyWith(
                        fontSize: 16, fontWeight: semibold),
                  ),
                )
              ],
            )
          ],
        ),
      );
    }

    Widget forgotPassword() {
      return Container(
        margin: const EdgeInsets.only(top: 8),
        child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/forgot-password'),
            child: Text(
              "Forgot Password?",
              textAlign: TextAlign.end,
              style: greyColorText,
            )),
      );
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        children: [
          header(),
          CustomForm(
            title: 'Email',
            textController: emailController,
            hintText: 'Enter your email address',
            prefixIcon: Icons.email_outlined,
          ),
          CustomForm(
            title: 'Password',
            textController: passwordController,
            hintText: 'Enter your Password',
            prefixIcon: Icons.lock_outline,
            isPassword: true,
          ),
          forgotPassword(),
          CustomButton(
            marginTop: 60,
            marginBottom: 80,
            heightButton: 53,
            radiusButton: 32,
            buttonColor: secondaryColor,
            buttonText: 'Login',
            onPressed: () {},
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(child: content()),
    );
  }
}
