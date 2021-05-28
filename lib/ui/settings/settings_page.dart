import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_news/style/locale/localization.dart';
import 'package:sport_news/style/theme/gallery_theme_data.dart';
import 'package:sport_news/ui/settings/settings/settings_bloc.dart';
import 'package:sport_news/ui/user_suggestion/user_suggestion.dart';
import 'package:sport_news/ui/widgets/header_mobile_widget.dart';
import 'package:sport_news/ui/widgets/settings_item.dart';

import '../../constants.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with TickerProviderStateMixin {
  bool isSwitched = false;
  AnimationController _animationController;
  Animation mainAnimationColor;
  Color beginColor;
  Color endColor;
  AnimationController _colorAnimationController;
  Animation<Offset> _slideAnimationBoxOne;
  bool clicked = false;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(seconds: 5), vsync: this)
          ..repeat(reverse: true);
    mainAnimationColor =
        ColorTween(begin: Color(0xFFFFCC00), end: Color(0xFFFF9500))
            .animate(_animationController);

    _colorAnimationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    _slideAnimationBoxOne =
        Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0)).animate(
      CurvedAnimation(parent: _colorAnimationController, curve: Curves.easeOut),
    );

    BlocProvider.of<SettingsBloc>(context)..add(SettingsEvent.init);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<SettingsBloc, SettingsState>(
      bloc: BlocProvider.of<SettingsBloc>(context),
      builder: (context, state) {
        if (state is ResetReccomendation) {
          Future.delayed(Duration.zero, () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(UserSuggestion.tag, (route) => false);
            BlocProvider.of<SettingsBloc>(context)..add(SettingsEvent.init);
          });
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderTitleMobileWidget(
                title: NewsLocalizations.of(context).settings),
            Padding(
              padding: const EdgeInsets.all(PADDING_LR_MEDIUM),
              child: Container(
                child: Column(children: [
                  SettingsItem(
                    rightPadding: false,
                    onPressed: () {
                      BlocProvider.of<SettingsBloc>(context)
                          .add(SettingsEvent.colorSelection);
                      _colorAnimationController.forward(from: 0);
                      clicked = true;
                    },
                    child: Row(children: [
                      AutoSizeText(NewsLocalizations.of(context).colorSelection,
                          style: Theme.of(context).textTheme.bodyText2),
                      Spacer(),
                      state.colorValue
                          ? SlideTransition(
                              position: _slideAnimationBoxOne,
                              child: Container(
                                height: SETTINGS_BUTTON_MIN_HEIGHT,
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    borderRadius: BorderRadius.circular(
                                        CIRCULAR_BORDER_RADIUS)),
                                child: Row(
                                  children: [
                                    colorGestureDetector(
                                        () => BlocProvider.of<SettingsBloc>(
                                                context)
                                            .add(SettingsEvent.pickLightTheme),
                                        NewsThemeData.settingsFirstLightColor,
                                        Theme.of(context).buttonColor,
                                        NewsLocalizations.of(context).daytime,
                                        Theme.of(context).backgroundColor),
                                    SizedBox(width: 10),
                                    colorGestureDetector(() {
                                      BlocProvider.of<SettingsBloc>(context)
                                          .add(SettingsEvent.pickDarkTheme);
                                    },
                                        NewsThemeData.settingsFirstDarkColor,
                                        NewsThemeData.settingsSecondDarkColor,
                                        NewsLocalizations.of(context).night,
                                        Theme.of(context).buttonColor),
                                  ],
                                ),
                              ),
                            )
                          : Padding(
                              padding:
                                  EdgeInsets.only(right: PADDING_LR_BIG_DETAIL),
                              child: clicked
                                  ? SlideTransition(
                                      position: _slideAnimationBoxOne,
                                      child: Icon(Icons.arrow_forward_ios,
                                          color: NewsThemeData
                                              .settingsButtonColor))
                                  : Icon(Icons.arrow_forward_ios,
                                      color: NewsThemeData.settingsButtonColor),
                            )
                    ]),
                  ),
                  SizedBox(height: 14),
                  SettingsItem(
                      rightPadding: true,
                      onPressed: () => BlocProvider.of<SettingsBloc>(context)
                          .add(SettingsEvent.resetRecommendations),
                      child: Row(children: [
                        AutoSizeText(
                            NewsLocalizations.of(context).resetRecommendations),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios,
                            color: NewsThemeData.settingsButtonColor)
                      ])),
                  SizedBox(height: 14),
                  SettingsItem(
                      rightPadding: true,
                      onPressed: () {},
                      child: Row(children: [
                        AutoSizeText(
                            NewsLocalizations.of(context).pointsOfNotification),
                        Spacer(),
                        Switch.adaptive(
                            activeTrackColor:
                                (mainAnimationColor.value as Color),
                            value: state.pointsValue,
                            onChanged: (value) =>
                                BlocProvider.of<SettingsBloc>(context)
                                    .add(SettingsEvent.pointsOfNotification))
                      ])),
                ]),
              ),
            ),
          ],
        );
      },
    ));
  }

  Widget colorGestureDetector(Function onTap, Color firstColor,
      Color secondColor, String themeName, Color textColor) {
    return GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              Row(children: [
                Icon(Icons.brightness_1, color: firstColor),
                Icon(Icons.brightness_1, color: secondColor)
              ]),
              AutoSizeText(themeName,
                  style: Theme.of(context)
                      .textTheme
                      .overline
                      .apply(color: textColor))
            ],
          ),
        ));
  }
}
