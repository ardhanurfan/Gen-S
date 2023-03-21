import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_player/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../shared/theme.dart';
import '../../widgets/custom_button.dart';
import 'reset_password_page.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    final TextEditingController pin1Controller =
        TextEditingController(text: '');
    final TextEditingController pin2Controller =
        TextEditingController(text: '');
    final TextEditingController pin3Controller =
        TextEditingController(text: '');
    final TextEditingController pin4Controller =
        TextEditingController(text: '');

    handleOtp() {
      String otp = pin1Controller.text +
          pin2Controller.text +
          pin3Controller.text +
          pin4Controller.text;
      if (otp == userProvider.tokenReset) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResetPasswordPage(email: email, otp: otp),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: alertColor,
            content: const Text(
              'OTP not valid, check your email again',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }

    return Scaffold(
      backgroundColor: backgroundUserColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          children: [
            Container(
              margin: const EdgeInsets.only(top: 60),
              child: Image.asset(
                "assets/otp_verification.png",
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 28),
            Text(
              'OTP Verification',
              style: primaryUserColorText.copyWith(
                fontSize: 24,
                fontWeight: bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  'Enter the OTP sent to ',
                  style: primaryUserColorText.copyWith(
                    fontSize: 16,
                  ),
                ),
                Expanded(
                  child: Text(
                    email.toString(),
                    style: primaryUserColorText.copyWith(
                        fontSize: 16, fontWeight: bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OtpForm(textController: pin1Controller),
                const SizedBox(width: 16),
                OtpForm(textController: pin2Controller),
                const SizedBox(width: 16),
                OtpForm(textController: pin3Controller),
                const SizedBox(width: 16),
                OtpForm(textController: pin4Controller),
                const SizedBox(width: 16),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t receive the code? ',
                  style: primaryUserColorText.copyWith(
                    fontSize: 16,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await userProvider.forgotPassword(email: email);
                  },
                  child: Text(
                    'Resend',
                    style: primaryUserColorText.copyWith(
                        fontSize: 16, fontWeight: bold),
                  ),
                ),
              ],
            ),
            CustomButton(
              marginTop: 24,
              marginBottom: 80,
              heightButton: 53,
              radiusButton: 32,
              buttonColor: secondaryColor,
              buttonText: 'Submit',
              onPressed: handleOtp,
            ),
          ],
        ),
      ),
    );
  }
}

class OtpForm extends StatelessWidget {
  const OtpForm({
    Key? key,
    required this.textController,
  }) : super(key: key);

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: TextField(
        controller: textController,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        obscureText: true,
        style: primaryUserColorText.copyWith(
          fontSize: 16,
          fontWeight: bold,
        ),
        cursorColor: primaryUserColor,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(16),
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
    );
  }
}
