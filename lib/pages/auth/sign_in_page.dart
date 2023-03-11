import 'package:flutter/material.dart';
import 'package:music_player/providers/audio_provider.dart';
import 'package:music_player/providers/playlist_provider.dart';
import 'package:music_player/shared/theme.dart';
import 'package:music_player/widgets/custom_button.dart';
import 'package:music_player/widgets/loading_button.dart';
import 'package:provider/provider.dart';

import '../../providers/page_provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/custom_form.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

bool isLoading = false;

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController =
        TextEditingController(text: '');
    final TextEditingController passwordController =
        TextEditingController(text: '');
    UserProvider userProvider = Provider.of<UserProvider>(context);
    PageProvider pageProvider = Provider.of<PageProvider>(context);
    AudioProvider audioProvider = Provider.of<AudioProvider>(context);
    PlaylistProvider playlistProvider = Provider.of<PlaylistProvider>(context);

    handleSignIn() async {
      setState(() {
        isLoading = true;
      });

      if (await userProvider.login(
        email: emailController.text,
        password: passwordController.text,
      )) {
        final navigator = Navigator.of(context);
        // Get Data User
        await audioProvider.getAudios(token: userProvider.user.token);
        await audioProvider.getHistory(token: userProvider.user.token);
        await playlistProvider.getPlaylist(token: userProvider.user.token);

        pageProvider.setPage = 0; // agar mulai di home
        navigator.pushNamedAndRemoveUntil('/main', (route) => false);
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
              "If you don't have an account register",
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
                  onTap: () => Navigator.pushNamed(context, '/sign-up'),
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
                  buttonText: 'Login',
                  onPressed: handleSignIn,
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
