import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sport_news/data/network/firebase_news.dart';
import 'package:sport_news/managers/firebase_manager.dart';
import 'package:sport_news/managers/shared_preference_manager.dart';
import 'package:sport_news/pr_extension.dart';
import 'package:sport_news/style/theme/gallery_theme_data.dart';
import 'dart:developer' as developer;

import '../../constants.dart';

class LikeWidget extends StatefulWidget {
  final FirebaseNews firebaseNews;
  const LikeWidget({
    required this.firebaseNews,
  });
  @override
  _LikeWidgetState createState() => _LikeWidgetState();
}

class _LikeWidgetState extends State<LikeWidget> {
  LikeBloc _bloc = LikeBloc();
  @override
  void initState() {
    super.initState();
    _bloc.getLiked(widget.firebaseNews);
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.firebaseNews.heroName! + "like_hero_widget_text_temp_tag",
      child: BlocBuilder<LikeBloc, bool>(
        bloc: _bloc,
        builder: (context, state) {
          var likeCount;
          if (widget.firebaseNews.likeCount! > 1000) {
            likeCount = "${widget.firebaseNews.likeCount! / 1000}";
          } else {
            likeCount = widget.firebaseNews.likeCount.toString();
          }

          return Center(
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                child: Icon(
                  state ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
                  color: NewsThemeData.saveButtonColor,
                  size: 20,
                ).paddingOnly(
                    left: PADDING_LR_VERY_SMALL,
                    right: PADDING_LR_MEDIUM,
                    top: 6,
                    bottom: 6),
              ),
              AutoSizeText(
                likeCount,
                style: Theme.of(context).textTheme.caption,
                maxLines: 3,
              ),
            ]),
          ).addOnTap(
            onTap: () {
              _bloc.like(widget.firebaseNews);
            },
          );
        },
      ),
    );
  }
}

class LikeBloc extends Cubit<bool> {
  LikeBloc() : super(false);
  SharedPreferenceManager _sharedPreferenceManager = SharedPreferenceManager();
  FirebaseManager _firebaseManager = FirebaseManager();

  init() {}
  getLiked(FirebaseNews news) {
    _sharedPreferenceManager.getLikeNewsRX(news.key!).listen((liked) {
      if (liked == null) liked = false;

      news.likedByUserTemp = liked;
      emit(news.likedByUserTemp);
    });
  }

  like(FirebaseNews news) async {
    news.likeCount = news.likeCount! + (state ? -1 : 1);
    news.likedByUserTemp = !state;
    emit(news.likedByUserTemp);
    _runUpdate(news);
  }

  _runUpdate(FirebaseNews news) {
    _sharedPreferenceManager.likeNews(news.key!, news.likedByUserTemp);
    // _firebaseManager.updateFirebaseNewsKeyValue(
    //     valName: 'like_count', val: news.likeCount, newsKey: news.key);
  }
}
