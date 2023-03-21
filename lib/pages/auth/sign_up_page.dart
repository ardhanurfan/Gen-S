import 'package:flutter/material.dart';
import 'package:music_player/providers/user_provider.dart';
import 'package:music_player/shared/theme.dart';
import 'package:music_player/widgets/custom_button.dart';
import 'package:music_player/widgets/loading_button.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_form.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

bool isLoading = false;

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController =
        TextEditingController(text: '');
    final TextEditingController usernameController =
        TextEditingController(text: '');
    final TextEditingController passwordController =
        TextEditingController(text: '');
    final TextEditingController confirmPasswordController =
        TextEditingController(text: '');
    UserProvider userProvider = Provider.of<UserProvider>(context);

    handleSignUp() async {
      setState(() {
        isLoading = true;
      });

      if (await userProvider.register(
        username: usernameController.text,
        email: emailController.text,
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
      )) {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: successColor,
            content: const Text(
              'Register success check your email verification',
              textAlign: TextAlign.center,
            ),
          ),
        );
        Navigator.pushNamedAndRemoveUntil(
            context, '/sign-in', (route) => false);
      } else {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: alertColor,
            content: Text(
              userProvider.errorMessage,
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

      setState(() {
        isLoading = false;
      });
    }

    Widget header() {
      return Container(
        margin: const EdgeInsets.only(top: 90),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sign up",
              style: primaryUserColorText.copyWith(fontSize: 30),
            ),
            const SizedBox(
              height: 22,
            ),
            Text(
              "If you already have an account register",
              style: primaryUserColorText.copyWith(fontSize: 16),
            ),
            const SizedBox(
              height: 6,
            ),
            Row(
              children: [
                Text(
                  "You can   ",
                  style: primaryUserColorText.copyWith(fontSize: 16),
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamedAndRemoveUntil(
                      context, '/sign-in', (route) => false),
                  child: Text(
                    "Login here!",
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
            title: 'Username',
            textController: usernameController,
            hintText: 'Enter your Username',
            prefixIcon: Icons.person_outline,
          ),
          CustomForm(
            title: 'Password',
            textController: passwordController,
            hintText: 'Enter your Password',
            prefixIcon: Icons.lock_outline,
            isPassword: true,
          ),
          CustomForm(
            title: 'Confirm Password',
            textController: confirmPasswordController,
            hintText: 'Confrim your Password',
            prefixIcon: Icons.lock_outline,
            isPassword: true,
          ),
          isLoading
              ? LoadingButton(
                  marginTop: 60,
                  marginBottom: 80,
                  heightButton: 53,
                  radiusButton: 32,
                  buttonColor: secondaryColor,
                )
              : CustomButton(
                  marginTop: 60,
                  marginBottom: 80,
                  heightButton: 53,
                  radiusButton: 32,
                  buttonColor: secondaryColor,
                  buttonText: 'Register',
                  onPressed: handleSignUp,
                ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: backgroundUserColor,
      body: SafeArea(child: content()),
    );
  }
}
