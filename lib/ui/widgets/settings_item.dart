import 'package:flutter/material.dart';
import 'package:sport_news/constants.dart';

class SettingsItem extends StatelessWidget {
  final Widget child;
  final Function onPressed;
  final bool rightPadding;

  SettingsItem({this.rightPadding, this.onPressed, this.child});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(CIRCULAR_BORDER_RADIUS)),
        padding: EdgeInsets.only(left: PADDING_LR_BIG_DETAIL, right: rightPadding ? PADDING_LR_BIG_DETAIL : 0),
        elevation: 0,
        constraints: BoxConstraints(minWidth: SETTINGS_BUTTON_MIN_WIDTH, minHeight: SETTINGS_BUTTON_MIN_HEIGHT),
        fillColor: Theme.of(context).colorScheme.surface,
        onPressed: onPressed,
        child: child);
  }
}
