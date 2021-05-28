import 'package:auto_size_text/auto_size_text.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_news/constants.dart';
import 'package:sport_news/managers/app_type_checker.dart';
import 'package:sport_news/pr_extension.dart';
import 'package:sport_news/style/locale/localization.dart';
import 'package:sport_news/style/theme/gallery_theme_data.dart';
import 'package:sport_news/ui/home/home_page.dart';
import 'package:sport_news/ui/user_suggestion/bloc/user_suggestion/user_suggestion_bloc.dart';
import 'package:sport_news/ui/widgets/custom_progress.dart';
import 'package:sport_news/ui/widgets/gradient_button.dart';
import 'package:sport_news/ui/widgets/stack_matrix.dart';
import 'package:sport_news/ui/widgets/staggered_user_suggestion.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class UserSuggestion extends StatefulWidget {
  static final String tag = '/user-suggestion';

  UserSuggestion({Key key}) : super(key: key);

  @override
  _UserSuggestionState createState() => _UserSuggestionState();
}

class _UserSuggestionState extends State<UserSuggestion>
    with TickerProviderStateMixin {
  var onDataAndShowShowCase = true;
  var steps = 1;
  var showcaseContext;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((Duration duration) {
      FeatureDiscovery.discoverFeatures(context, <String>{steps.toString()});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    return Scaffold(body: Center(child: mobile()));
  }

  mobile() {
    var topText = {
      NewsLocalizations.of(context).tellMe,
      NewsLocalizations.of(context).selectFavorite,
      NewsLocalizations.of(context).finishSettingsUp
    };
    var topDescription = {
      NewsLocalizations.of(context).chooseCategories,
      NewsLocalizations.of(context).clickAndLinger,
      NewsLocalizations.of(context).justMakeSure
    };

    final screenHeight = MediaQuery.of(context).size.height;
    final itemSize = (screenHeight / 2) / 4;

    return BlocBuilder<UserSuggestionBloc, UserSuggestionState>(
        bloc: BlocProvider.of<UserSuggestionBloc>(context)
          ..add(UserSuggestionEvent.init),
        builder: (c, state) {
          var inStackPlaceWidget =
              (state.categories == null || state.categories.isEmpty)
                  ? CustomProgress()
                  : StackMatrix(
                      startSize: itemSize,
                      deltaSize: itemSize / 3,
                      deltaSizeBig: itemSize * 1.8,
                      items: state.categories,
                      itemSelected: (SuggestionItem i) {
                        BlocProvider.of<UserSuggestionBloc>(context)
                            .updateCategory(i);
                        showShowCase();
                      },
                    );

          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedSwitcher(
                        duration: const Duration(milliseconds: 600),
                        switchInCurve: Curves.easeInQuart,
                        child: AutoSizeText(
                          topText.elementAt(steps - 1),
                          maxLines: 2,
                          key: ValueKey(topText.elementAt(steps - 1)),
                          style: Theme.of(context).textTheme.headline1,
                        ))
                    .paddingOnly(
                        top: PADDING_TOP_BIG_SUGGESTION,
                        left: PADDING_LR_MEDIUM,
                        right: PADDING_LR_MEDIUM),
                AnimatedSwitcher(
                        duration: const Duration(milliseconds: 800),
                        child: AutoSizeText(
                          topDescription.elementAt(steps - 1),
                          key: ValueKey(topDescription.elementAt(steps - 1)),
                          style: Theme.of(context).textTheme.bodyText2,
                        ))
                    .paddingOnly(
                        top: 4,
                        left: PADDING_LR_MEDIUM,
                        right: PADDING_LR_MEDIUM),
                Flexible(
                  child: Stack(
                    children: [
                      Positioned(
                          top: 0, left: 0, right: 0, child: inStackPlaceWidget),
                      discoveryMatrixWidget(),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          color: Colors.black.withOpacity(0.3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: new BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: new Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                  size: 20,
                                ).paddingAll(10),
                              ).paddingOnly(left: 10).addOnTap(onTap: () {
                                if (steps > 1)
                                  setState(() {
                                    steps--;
                                  });
                              }),
                              //mard centr circle
                              steps < 3
                                  ? Container(
                                      width: 52,
                                      height: 52,
                                      decoration: new BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          CircularStepProgressIndicator(
                                            totalSteps: 3,
                                            currentStep: steps,
                                            stepSize: 1,
                                            selectedColor: NewsThemeData
                                                .bottomBarBackgroundColor,
                                            unselectedColor: Colors.grey[200],
                                            padding: 0,
                                            width: 45,
                                            height: 45,
                                            selectedStepSize: 4,
                                          ),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                AutoSizeText(
                                                  steps.toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .copyWith(
                                                          fontSize: 22,
                                                          color: Colors.black),
                                                ),
                                                Opacity(
                                                  opacity: 0.6,
                                                  child: AutoSizeText(
                                                    NewsLocalizations.of(
                                                            context)
                                                        .lastPage,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline5
                                                        .copyWith(
                                                            fontSize: 14,
                                                            color:
                                                                Colors.black),
                                                  ).paddingOnly(right: 4),
                                                ),
                                              ]),
                                        ],
                                      ),
                                    )
                                  : Container(
                                      child: GradientButton(
                                        innerText:
                                            NewsLocalizations.of(context).next,
                                        padding: 60,
                                      ).addOnTap(onTap: navigateToNextScreen),
                                    ),
                              discoveryNextPress(),
                            ],
                          ).paddingAll(6),
                        ),
                      ),
                    ],
                  ),
                ),
              ]);
        });
  }

  discoveryNextPress() {
    return DescribedFeatureOverlay(
      title: AutoSizeText(NewsLocalizations.of(context).steps),
      description: AutoSizeText(NewsLocalizations.of(context).clickHere),
      featureId: 'next_arrow',
      tapTarget: const Icon(Icons.arrow_forward),
      textColor: Theme.of(context).colorScheme.background,
      backgroundColor: Theme.of(context).colorScheme.primaryVariant,
      targetColor: Theme.of(context).colorScheme.background.withOpacity(0.5),
      child: Container(
        decoration: new BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: new Icon(
          Icons.arrow_forward,
          color: Colors.black,
          size: 20,
        ).paddingAll(10),
      ).paddingAll(10).addOnTap(onTap: onTapNext),
    );
  }

  discoveryMatrixWidget() {
    final text = steps == 1
        ? NewsLocalizations.of(context).chooseCategories
        : NewsLocalizations.of(context).clickAndLinger;

    return Align(
      alignment: Alignment.centerRight,
      child: DescribedFeatureOverlay(
        contentLocation: ContentLocation.above,
        title: AutoSizeText(NewsLocalizations.of(context).tellMe),
        description: AutoSizeText(text),
        featureId: steps.toString(),
        tapTarget: Container(
          child: CardItemWidget(
            iconData: Icons.hd,
            name: "Hockey",
            localImage: DRAWABLE_SUGGESTION_PLACEHOLDER,
            el: SuggestionItem(
                data: null,
                name: "Hockey",
                // image:
                //     "https://drive.google.com/u/0/uc?id=1vQr15iSgWjv1ZfC4fYfWn3K-YXAVTmlN&export=download",
                icon:
                    "https://drive.google.com/u/0/uc?id=1QC7CkyCHRoyYj6SChFUi80vAPxwr297L&export=download",
                currentWeight: 1),
          ),
        ),
        textColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Theme.of(context).colorScheme.primaryVariant,
        targetColor: Theme.of(context).colorScheme.background.withOpacity(0.5),
        overflowMode: OverflowMode.ignore,
        child: SizedBox.shrink(),
      ).paddingOnly(right: 70, top: 50),
    );
  }

  void showShowCase() {
    if (onDataAndShowShowCase) {
      onDataAndShowShowCase = false;
      Future.delayed(const Duration(seconds: 1), () {
        FeatureDiscovery.discoverFeatures(context, {'next_arrow'});
      });
    }
  }

  onTapNext() {
    if (steps < 3) {
      setState(() {
        steps++;
      });
    }
    if (steps == 2)
      Future.delayed(
          const Duration(milliseconds: 300),
          () => FeatureDiscovery.discoverFeatures(
              context, <String>{steps.toString()}));
  }

  navigateToNextScreen() {
    Navigator.pushNamedAndRemoveUntil(context, HomePage.tag, (route) => false);
  }
}
