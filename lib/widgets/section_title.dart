import 'package:flutter/material.dart';
import 'package:music_player/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../shared/theme.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    required this.title,
    required this.onTap,
    this.marginTop = 0,
    Key? key,
  }) : super(key: key);

  final String title;
  final Function() onTap;
  final double marginTop;

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Container(
      margin: EdgeInsets.only(bottom: 24, top: marginTop),
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style:
                (userProvider.user?.role == "USER" || userProvider.user == null
                        ? primaryUserColorText
                        : primaryAdminColorText)
                    .copyWith(fontSize: 24, fontWeight: bold),
          ),
          InkWell(
            onTap: onTap,
            highlightColor:
                userProvider.user?.role == "USER" || userProvider.user == null
                    ? const Color.fromARGB(255, 73, 73, 73)
                    : const Color.fromARGB(255, 200, 200, 200),
            child: Text(
              'Show All',
              style:
                  secondaryColorText.copyWith(fontSize: 12, fontWeight: medium),
            ),
          )
        ],
      ),
    );
  }
}
