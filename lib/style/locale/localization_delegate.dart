import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'localization.dart';

class NewsLocalizationsDelegate
    extends LocalizationsDelegate<NewsLocalizations> {
  const NewsLocalizationsDelegate();

  static const NewsLocalizationsDelegate delegate =
      const NewsLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
  ];

  @override
  bool isSupported(Locale locale) =>
      ['en', 'es', 'ru'].contains(locale.languageCode);

  @override
  Future<NewsLocalizations> load(Locale locale) {
    return SynchronousFuture<NewsLocalizations>(NewsLocalizations(locale));
  }

  @override
  bool shouldReload(NewsLocalizationsDelegate old) => false;
}
