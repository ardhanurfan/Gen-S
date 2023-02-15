import 'package:flutter/material.dart';

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
    return Container(
      margin: EdgeInsets.only(bottom: 24, top: marginTop),
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: primaryColorText.copyWith(fontSize: 24, fontWeight: bold),
          ),
          GestureDetector(
            onTap: onTap,
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
