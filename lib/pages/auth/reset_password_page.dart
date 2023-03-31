import 'package:flutter/material.dart';
import 'package:music_player/providers/user_provider.dart';
import 'package:music_player/shared/theme.dart';
import 'package:music_player/widgets/custom_button.dart';
import 'package:music_player/widgets/loading_button.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_form.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key, required this.email, required this.otp});

  final String email;
  final String otp;

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

bool isLoading = false;

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController passwordController =
        TextEditingController(text: '');
    final TextEditingController confirmPasswordController =
        TextEditingController(text: '');
    UserProvider userProvider = Provider.of<UserProvider>(context);

    handleSignUp() async {
      setState(() {
        isLoading = true;
      });

      if (await userProvider.resetPassword(
        email: widget.email,
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
        token: int.parse(widget.otp),
      )) {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: successColor,
            content: const Text(
              'Reset password successfully',
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
              "Reset Password",
              style: primaryUserColorText.copyWith(fontSize: 30),
            ),
            const SizedBox(
              height: 22,
            ),
            Text(
              "Enter your new password",
              style: primaryUserColorText.copyWith(fontSize: 16),
            ),
          ],
        ),
      );
    }

    Widget content() {
      return ListView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        children: [
          header(),
          CustomForm(
            title: 'New Password',
            textController: passwordController,
            hintText: 'Enter your new Password',
            prefixIcon: Icons.lock_outline,
            isPassword: true,
          ),
          CustomForm(
            title: 'Confirm New Password',
            textController: confirmPasswordController,
            hintText: 'Confrim your new Password',
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
                  buttonText: 'Reset Password',
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
