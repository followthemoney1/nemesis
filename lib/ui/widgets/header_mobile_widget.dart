import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class HeaderTitleMobileWidget extends StatelessWidget {
  final String title;

  HeaderTitleMobileWidget({this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: PADDING_LR_MEDIUM,
        right: PADDING_LR_MEDIUM,
      ),
      child: AutoSizeText(title,
          maxLines: 1,
          minFontSize: 26,
          maxFontSize: 46,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headline1
              .apply(letterSpacingDelta: 0.64)),
    );
  }
}
