import 'package:flutter/material.dart';
import 'package:music_player/providers/user_provider.dart';
import 'package:music_player/shared/theme.dart';
import 'package:music_player/widgets/loading_button.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_button.dart';
import 'otp_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

bool isLoading = false;

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController =
        TextEditingController(text: '');
    UserProvider userProvider = Provider.of<UserProvider>(context);

    handleForgot() async {
      setState(() {
        isLoading = true;
      });

      if (await userProvider.forgotPassword(email: emailController.text)) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpPage(email: emailController.text),
          ),
        );
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

    return Scaffold(
      backgroundColor: backgroundUserColor,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          children: [
            Container(
              margin: const EdgeInsets.only(top: 120),
              child: Image.asset(
                "assets/forgot_password.png",
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 47),
            Text(
              'Forgot Password',
              style: primaryUserColorText.copyWith(
                fontSize: 24,
                fontWeight: bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Don\'t worry! It happens. Please enter the phone number we will send the OTP in this phone number.',
              style: primaryUserColorText.copyWith(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 48),
            TextFormField(
              controller: emailController,
              style: primaryUserColorText.copyWith(fontSize: 14),
              cursorColor: primaryUserColor,
              decoration: InputDecoration(
                isCollapsed: true,
                contentPadding: const EdgeInsets.all(16),
                hintText: 'Enter your email address',
                hintStyle: primaryUserColorText.copyWith(
                  fontSize: 12,
                  fontWeight: light,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: BorderSide(
                    color: secondaryColor,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: BorderSide(
                    color: primaryUserColor,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ),
            isLoading
                ? LoadingButton(
                    marginTop: 24,
                    marginBottom: 80,
                    heightButton: 53,
                    radiusButton: 32,
                    buttonColor: secondaryColor,
                  )
                : CustomButton(
                    marginTop: 24,
                    marginBottom: 80,
                    heightButton: 53,
                    radiusButton: 32,
                    buttonColor: secondaryColor,
                    buttonText: 'Continue',
                    onPressed: handleForgot,
                  ),
          ],
        ),
      ),
    );
  }
}
