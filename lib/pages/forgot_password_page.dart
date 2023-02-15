import 'package:flutter/material.dart';
import 'package:music_player/pages/otp_page.dart';
import 'package:music_player/shared/theme.dart';

import '../widgets/custom_button.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController =
        TextEditingController(text: '');
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: ListView(
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
              style: primaryColorText.copyWith(
                fontSize: 24,
                fontWeight: bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Don’t worry! It happens. Please enter the phone number we will send the OTP in this phone number.',
              style: primaryColorText.copyWith(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 48),
            TextFormField(
              controller: emailController,
              style: primaryColorText.copyWith(fontSize: 14),
              cursorColor: primaryColor,
              decoration: InputDecoration(
                isCollapsed: true,
                contentPadding: const EdgeInsets.all(16),
                hintText: 'Enter your email address',
                hintStyle: primaryColorText.copyWith(
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
                    color: primaryColor,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ),
            CustomButton(
              marginTop: 24,
              marginBottom: 80,
              heightButton: 53,
              radiusButton: 32,
              buttonColor: secondaryColor,
              buttonText: 'Continue',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OtpPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
