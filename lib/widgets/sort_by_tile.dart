import 'package:flutter/material.dart';
import 'package:music_player/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../providers/sort_by_provider.dart';
import '../shared/theme.dart';

class SortByTile extends StatelessWidget {
  const SortByTile({
    Key? key,
    required this.title,
    required this.index,
  }) : super(key: key);

  final String title;
  final int index;

  @override
  Widget build(BuildContext context) {
    SortByProvider sortByProvider = Provider.of<SortByProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: userProvider.user?.role == "USER" || userProvider.user == null
              ? primaryUserColorText.copyWith(
                  fontSize: 12,
                )
              : primaryAdminColorText.copyWith(
                  fontSize: 12,
                ),
        ),
        Icon(
            sortByProvider.sortBy == index
                ? Icons.check_circle_outline
                : Icons.circle_outlined,
            color:
                userProvider.user?.role == "USER" || userProvider.user == null
                    ? primaryUserColor
                    : primaryAdminColor)
      ],
    );
  }
}
