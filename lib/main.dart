import 'package:feature_discovery/feature_discovery.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sport_news/routes.dart';
import 'package:sport_news/style/locale/localization_delegate.dart';
import 'package:sport_news/style/theme/gallery_option.dart';
import 'package:sport_news/style/theme/gallery_theme_data.dart';
import 'package:sport_news/ui/admin/admin_panel.dart';
import 'package:sport_news/ui/admin/admin_panel_controller.dart';
import 'package:sport_news/ui/header/header.dart';
import 'package:sport_news/ui/home/home_page.dart';
import 'package:sport_news/ui/news_detail/news_detail/news_detail_bloc.dart';
import 'package:sport_news/ui/news_detail/news_detail_page.dart';

import 'package:sport_news/ui/settings/settings/settings_bloc.dart';
import 'package:sport_news/ui/user_suggestion/bloc/user_suggestion/user_suggestion_bloc.dart';
import 'dart:developer' as developer;
import 'constants.dart';
import 'di/initial_binding.dart';
import 'pr_extension.dart';
import 'managers/firebase_manager.dart';
import 'managers/shared_preference_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GoogleFonts.config.allowRuntimeFetching = true;

  runApp(
    SportNews(),
  );
}

class SportNews extends StatefulWidget {
  @override
  _SportNewsState createState() => _SportNewsState();
}

class _SportNewsState extends State<SportNews> {
  ThemeMode _themeMode = ThemeMode.dark;
  SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();

  @override
  void initState() {
    super.initState();

    // sharedPreferenceManager.getThemeStream().listen((event) {
    //   setState(() {
    //     if (event == 0) {
    //       _themeMode = ThemeMode.light;
    //     } else if (event != null) {
    //       _themeMode = ThemeMode.dark;
    //     }
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
      /// set toast style, optional
      child: ModelBinding(
        initialModel: GalleryOptions(
          textScaleFactor: systemTextScaleFactorOption,
          customTextDirection: CustomTextDirection.localeBased,
          // locale: Locale('ru'),
          timeDilation: timeDilation,
          platform: defaultTargetPlatform,
          isTestMode: true,
        ),
        child: Builder(builder: (context) {
          return FeatureDiscovery(
            child: GetMaterialApp(
              localeResolutionCallback:
                  (Locale? locale, Iterable<Locale> supportedLocales) {
                return locale;
              },
              smartManagement: SmartManagement.full,
              getPages: RouteConfiguration.pages,
              // onGenerateRoute: RouteConfiguration.onGenerateRoute,
              initialBinding: InitialBinding(),
              initialRoute: HomePage.page,
              // initialRoute: AdminPanel.page,
              debugShowCheckedModeBanner: false,
              themeMode: _themeMode != null
                  ? _themeMode
                  : GalleryOptions.of(context)!.themeMode!,
              theme: NewsThemeData.lightThemeData.copyWith(
                platform: GalleryOptions.of(context)!.platform,
              ),
              darkTheme: NewsThemeData.darkThemeData.copyWith(
                platform: GalleryOptions.of(context)!.platform,
              ),
              localizationsDelegates: [
                ...NewsLocalizationsDelegate.localizationsDelegates,
              ],
              supportedLocales: [...NewsLocalizationsDelegate.supportedLocales],
            ),
          );
        }),
      ),
    );
  }
}
