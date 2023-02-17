import 'package:flutter/material.dart';
import 'package:music_player/providers/page_provider.dart';
import 'package:provider/provider.dart';

import '../../shared/theme.dart';
import 'home_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);

    Widget buildContent() {
      int newPage = pageProvider.page;
      switch (newPage) {
        case 0:
          {
            return const HomePage();
          }
        case 1:
          {
            return const HomePage();
          }
        case 2:
          {
            return const HomePage();
          }
        case 3:
          {
            return const HomePage();
          }
        default:
          {
            return const HomePage();
          }
      }
    }

    Widget customBottomNavigation() {
      return const SizedBox();
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          buildContent(),
          customBottomNavigation(),
        ],
      ),
    );
    ;
  }
}
