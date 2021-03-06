//
//OTHER
//

import 'dart:math';
import 'dart:ui';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TeamsCategoryConstants {
  static final DOTA2 = 'ZFP7tRnG0Z8HgOzua9Mi';
  static final CSGO = 'kBequSKya9RKn8Wnee8N';
  static final LEAGUE_OF_LEGENDS = 'RENus071K9skU6ZKX0gT';
}

launchURL(String url, {autolaunch = true}) async {
  if (await canLaunch(url)) {
    //await launch(url);

  } else {
    throw 'Could not launch $url';
  }
}

class LoadStateWidget extends StatelessWidget{
  ExtendedImageState state;
  LoadStateWidget(this.state);

  @override
  Widget build(BuildContext context) {
    final placecholder = ColorFiltered(
  colorFilter: ColorFilter.mode(
    Colors.grey,
    BlendMode.saturation,
  ),
  child:Image.asset(
        PLACEHOLDERS[8],
        fit: BoxFit.cover,
        
      ),);
  switch (state.extendedImageLoadState) {
    case LoadState.loading:
      return placecholder;
      break;

    case LoadState.completed:
      return state.completedWidget;
      break;
    case LoadState.failed:
      return placecholder;
      break;
    default:
      return placecholder;
  }

  return Container();
  }

}

Widget loadImageStateFunction(ExtendedImageState state) {
  final placecholder = Image.asset(
        PLACEHOLDERS[Random().nextInt(1)],
        fit: BoxFit.cover,
      );
  switch (state.extendedImageLoadState) {
    case LoadState.loading:
      return placecholder;
      break;

    case LoadState.completed:
      return state.completedWidget;
      break;
    case LoadState.failed:
      return placecholder;
      break;
    default:
      return placecholder;
  }

  return Container();
}

//
// ICONS
//

const String ICON_MENU_BOTTOM_BAR_NEWS = "assets/icons/menu_news_icon.svg";
const String ICON_MENU_BOTTOM_BAR_RECOMMENDED =
    "assets/icons/menu_recommended_icon.svg";
const String ICON_SUPERLIKE_CATEGORY = "assets/icons/category_superlike.png";
const String DRAWABLE_SUGGESTION_PLACEHOLDER =
    "assets/images/placeholder_suggestion.jpg";

const String DRAWABLE_NEWS_PLACEHOLDER = "assets/drawable/news_placeholder.png";
const List<String> PLACEHOLDERS = [
  "assets/placeholders/1.png",
  "assets/placeholders/2.png",
  "assets/placeholders/3.png",
  "assets/placeholders/4.png",
  "assets/placeholders/5.png",
  "assets/placeholders/6.png",
  "assets/placeholders/7.png",
  "assets/placeholders/8.png",
  "assets/placeholders/9.png",
  "assets/placeholders/10.png"
];

const String DRAWABLE_FILTER_ICON = "assets/icons/filter_icon.svg";

//
//TEST STYLE
//

//
//PADDINGS
//

const PADDING_LR_VERY_SMALL = 4.0;
const PADDING_TOP_SMALL = 14.0;

const PADDING_LR_MEDIUM = 12.0;
const PADDING_TOP_MEDIUM = 28.0;
const PADDING_BOTTOM_MEDIUM = 82.0;

const PADDING_TOP_BIG_SUGGESTION = 36.0;
const PADDING_LR_BIG_DETAIL = 14.0;
const PADDING_TOP_BIG_DETAIL = 106.0;
const PADDING_BOTTOM_BIG_DETAIL = 82.0;

const BUTTON_BORDER_RADIUS = 28.0;

//
//OTHER
//
const CIRCULAR_BORDER_RADIUS = 7.0;
const SETTINGS_BUTTON_MIN_WIDTH = 361.0;
const SETTINGS_BUTTON_MIN_HEIGHT = 44.0;
const FILTER_BUTTON_MIN_WIDTH = 184.0;
const FILTER_BUTTON_MIN_HEIGHT = 50.0;

// height of the 'Gallery' header
const double galleryHeaderHeight = 64;

// The font size delta for headline4 font.
const double desktopDisplay1FontDelta = 16;

// The width of the settingsDesktop.
const double desktopSettingsWidth = 520;

// Sentinel value for the system text scale factor option.
const double systemTextScaleFactorOption = -1;

// The splash page animation duration.
const splashPageAnimationDurationInMilliseconds = 300;

// The desktop top padding for a page's first header (e.g. Gallery, Settings)
const firstHeaderDesktopTopPadding = 5.0;
