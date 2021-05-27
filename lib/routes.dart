import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sport_news/ui/admin/admin_panel.dart';
import 'package:sport_news/ui/admin/admin_panel_controller.dart';
import 'package:sport_news/ui/admin/create_new_team/create_new_team.dart';
import 'package:sport_news/ui/admin/create_new_team/create_team_controller.dart';
import 'package:sport_news/ui/filter/filter_page.dart';
import 'package:sport_news/ui/home/home_page.dart';
import 'package:sport_news/ui/news_detail/news_detail_page.dart';
import 'package:sport_news/ui/user_suggestion/user_suggestion.dart';

import 'di/root_binding.dart';

typedef PathWidgetBuilder = Widget Function(BuildContext, String);

class Path {
  const Path(this.pattern, this.builder);

  /// A RegEx string for route matching.
  final String pattern;

  /// The builder for the associated pattern route. The first argument is the
  /// [BuildContext] and the second argument a RegEx match if that is included
  /// in the pattern.
  ///
  /// ```dart
  /// Path(
  ///   'r'^/demo/([\w-]+)$',
  ///   (context, matches) => Page(argument: match),
  /// )
  /// ```
  final PathWidgetBuilder builder;
}

class RouteConfiguration {
  /// List of [Path] to for route matching. When a named route is pushed with
  /// [Navigator.pushNamed], the route name is matched with the [Path.pattern]
  /// in the list below. As soon as there is a match, the associated builder
  /// will be returned. This means that the paths higher up in the list will
  /// take priority.
  ///
  static final pages = [
    GetPage(
      name: HomePage.tag,
      page: () => HomePage(),
      binding: RootBinding(),
    ),
    GetPage(
      name: AdminPanel.page,
      page: () => AdminPanel(),
      binding: BindingsBuilder(
        () => Get.lazyPut<AdminPanelController>(
          () => AdminPanelController(),
        ),
      ),
    ),
    // GetPage(
    //   name: CreateTeam.page,
    //   page: () => CreateTeam(),
    //   binding: BindingsBuilder(
    //     () => 
    //     ),
    //   ),
    // ),
  ];

  static List<Path> paths = [
    Path(
      HomePage.tag, //+ r'([\w-]+)$',
      (context, match) => HomePage(),
    ),
    Path(
      NewsDetailPage.tag, //+ r'/([\w-]+)$',
      (context, match) => NewsDetailPage(),
    ),
    Path(
      UserSuggestion.tag, //+ r'/([\w-]+)$',
      (context, match) => UserSuggestion(),
    ),
    Path(
      FilterPage.tag, //+ r'/([\w-]+)$',
      (context, match) => FilterPage(),
    ),
    Path(
      AdminPanel.page,
      (context, match) => AdminPanel(),
    ),
    // Path(
    //   CreateTeam.page,
    //   (context, match) => CreateTeam(),
    // ),
  ];
//
//  static List<Path> paths = [
//    Path(
//      HomePage.tag, // + r'/([\w-]+)$',
//      (context, match) => HomePage(),
//    ),
//    Path(
//      NewsDetailPage.tag,
//      (context, match) => NewsDetailPage(),
//    ),
//  ];

  /// The route generator callback used when the app is navigated to a named
  /// route. Set it on the [MaterialApp.onGenerateRoute] or
  /// [WidgetsApp.onGenerateRoute] to make use of the [paths] for route
  /// matching.
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    for (final path in paths) {
      final regExpPattern = RegExp(path.pattern);

      if (regExpPattern.hasMatch(settings.name)) {
        final firstMatch = regExpPattern.firstMatch(settings.name);
        final match = (firstMatch.groupCount == 1) ? firstMatch.group(1) : null;
        if (kIsWeb) {
          return NoAnimationMaterialPageRoute<void>(
            builder: (context) => path.builder(context, match),
            settings: settings,
          );
        }
        return MaterialPageRoute<void>(
          builder: (context) => path.builder(context, match),
          settings: settings,
        );
      } else {
        print("4040404040404040");
      }
    }

    // If no match was found, we let [WidgetsApp.onUnknownRoute] handle it.
    return null;
  }
}

class NoAnimationMaterialPageRoute<T> extends MaterialPageRoute<T> {
  NoAnimationMaterialPageRoute({
    @required WidgetBuilder builder,
    RouteSettings settings,
  }) : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}
