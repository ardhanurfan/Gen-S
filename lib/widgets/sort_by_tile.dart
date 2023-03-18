import 'package:flutter/material.dart';
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

    return GestureDetector(
        onTap: () {
          sortByProvider.setHomePage = index;
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: primaryColorText.copyWith(
                fontSize: 12,
              ),
            ),
            Icon(
                sortByProvider.homePage == index
                    ? Icons.check_circle_outline
                    : Icons.circle_outlined,
                color: primaryColor)
          ],
        ));
  }
}
