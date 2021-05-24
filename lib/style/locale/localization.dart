import 'dart:ui';

import 'package:flutter/material.dart';

class NewsLocalizations {
  NewsLocalizations(this.locale);

  final Locale locale;

  static NewsLocalizations of(BuildContext context) {
    return Localizations.of<NewsLocalizations>(context, NewsLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'titleNews': 'News',
      'allNews': 'All news',
      'saved': 'Saved',
      'recommended': 'Recommended',
      'settings': 'Settings',
      'colorSelection': 'Color selection',
      'resetRecommendations': 'Reset recommendations',
      'pointsOfNotification': 'Push notifications',
      'daytime': 'Daytime',
      'night': 'Night',
      'filters': 'Filters',
      'select': 'Select',
      'topNews': 'Top news',
      'importantInformation': 'Important information',
      'fka': 'FKA twigs - LP1',
      'tellMe': 'Tell me what you like?',
      'lastPage': '/3',
      'next': 'Next',
      'steps': 'Steps',
      'clickHere': 'Click here to move to next step',
      'watchAVideo': 'Try yourself',
      'selectFavorite': 'Select you Favorite category',
      'finishSettingsUp': 'Finish setting up suggestions',
      'chooseCategories':
          'Choose one or more categories that you like. Just click on them.',
      'clickAndLinger':
          'Click and hold on a category to make it your favorite.',
      'justMakeSure':
          'Just make sure to choose whatever you like, now we can go further',
      'noSavedNewsYet': 'No saved news yet',
      'noNewData': 'There is no new data here yet 🤔'
    },
    'ru': {
      'titleNews': 'Новости',
      'allNews': 'Все новости',
      'saved': 'Сохраненные',
      'recommended': 'Рекомендуемые',
      'settings': 'Настройки',
      'colorSelection': 'Выбор цвета',
      'resetRecommendations': 'Сбросить рекомендации',
      'pointsOfNotification': 'Получать нотификации',
      'daytime': 'Дневное время',
      'night': 'Ночь',
      'filters': 'Фильтры',
      'select': 'Выбрать',
      'topNews': 'Популярные новости',
      'importantInformation': 'Важная информация',
      'fka': 'FKA twigs - LP1',
      'tellMe': 'Расскажи нам что тебе нравится',
      'lastPage': '/3',
      'next': 'Дальше',
      'steps': 'Шаги',
      'clickHere': 'Щелкни здесь, чтобы перейти к следующему шагу',
      'watchAVideo': 'Попробовать себя',
      'selectFavorite': 'Выбери любимые категории',
      'finishSettingsUp': 'Заверши настройку рекомендаций',
      'chooseCategories':
          'Выбери одну или несколько категорий, которые тебе нравятся. Просто нажми на каждую.',
      'clickAndLinger': 'Нажми и удерживай категории, которые ты любишь.',
      'justMakeSure':
          'Убедись, что отметил все понравившиеся категории и переходи дальше.',
      'noSavedNewsYet': 'Здесь еще нет сохраненных новостей',
      'noNewData': 'Здесь еще нет новых данных 🤔'
    },
  };

  String get noNewData {
    return _localizedValues[locale.languageCode]['noNewData'];
  }

  String get noSavedNewsYet {
    return _localizedValues[locale.languageCode]['noSavedNewsYet'];
  }

  String get titleNews {
    return _localizedValues[locale.languageCode]['titleNews'];
  }

  String get allNews {
    return _localizedValues[locale.languageCode]['allNews'];
  }

  String get saved {
    return _localizedValues[locale.languageCode]['saved'];
  }

  String get recommended {
    return _localizedValues[locale.languageCode]['recommended'];
  }

  String get settings {
    return _localizedValues[locale.languageCode]['settings'];
  }

  String get colorSelection {
    return _localizedValues[locale.languageCode]['colorSelection'];
  }

  String get pointsOfNotification {
    return _localizedValues[locale.languageCode]['pointsOfNotification'];
  }

  String get resetRecommendations {
    return _localizedValues[locale.languageCode]['resetRecommendations'];
  }

  String get daytime {
    return _localizedValues[locale.languageCode]['daytime'];
  }

  String get night {
    return _localizedValues[locale.languageCode]['night'];
  }

  String get filters {
    return _localizedValues[locale.languageCode]['filters'];
  }

  String get select {
    return _localizedValues[locale.languageCode]['select'];
  }

  String get topNews {
    return _localizedValues[locale.languageCode]['topNews'];
  }

  String get importantInformation {
    return _localizedValues[locale.languageCode]['importantInformation'];
  }

  String get fka {
    return _localizedValues[locale.languageCode]['fka'];
  }

  String get tellMe {
    return _localizedValues[locale.languageCode]['tellMe'];
  }

  String get lastPage {
    return _localizedValues[locale.languageCode]['lastPage'];
  }

  String get next {
    return _localizedValues[locale.languageCode]['next'];
  }

  String get steps {
    return _localizedValues[locale.languageCode]['steps'];
  }

  String get clickHere {
    return _localizedValues[locale.languageCode]['clickHere'];
  }

  String get watchAVideo {
    return _localizedValues[locale.languageCode]['watchAVideo'];
  }

  String get selectFavorite {
    return _localizedValues[locale.languageCode]['selectFavorite'];
  }

  String get finishSettingsUp {
    return _localizedValues[locale.languageCode]['finishSettingsUp'];
  }

  String get chooseCategories {
    return _localizedValues[locale.languageCode]['chooseCategories'];
  }

  String get clickAndLinger {
    return _localizedValues[locale.languageCode]['clickAndLinger'];
  }

  String get justMakeSure {
    return _localizedValues[locale.languageCode]['justMakeSure'];
  }
}
