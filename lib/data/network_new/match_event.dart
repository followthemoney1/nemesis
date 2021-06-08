import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sport_news/data/helper/pair.dart';
import 'package:sport_news/data/local/local_team.dart';
import 'package:sport_news/data/network_new/game_category.dart';
import 'package:sport_news/pr_extension.dart';

class MatchEvent {
  late String snapshotId;
  late DateTime schedule;
  late int bo;
  late String matchStreamUrl;
  int likeCount = 0;
  int viewCount = 0;
  int shareCount = 0;

  LocalTeam? team1;
  LocalTeam? team2;
  MatchEvent();

  MatchEvent.fromSnapshot(DocumentSnapshot snapshot) {
    this.snapshotId = snapshot.id;
    // this.image = snapshot['image'];
    final t1ID = snapshot['team1'];
    final t2ID = snapshot['team2'];
    this.team1 = LocalTeam()..snapshotId = t1ID;
    this.team2 = LocalTeam()..snapshotId = t2ID;

    this.bo = snapshot['bo'];
    this.matchStreamUrl = snapshot['matchStreamUrl'];
    this.schedule = (snapshot['schedule'] as Timestamp).toDate();
    this.likeCount = snapshot.hasKey('like_count') ? snapshot['like_count'] : 0;
    this.viewCount = snapshot.hasKey('view_count') ? snapshot['view_count'] : 0;
    this.shareCount =
        snapshot.hasKey('share_count') ? snapshot['share_count'] : 0;

    log(likeCount.toString());
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> snapshot = new Map<String, dynamic>();
    snapshot['team1'] = this.team1!.snapshotId;
    snapshot['team2'] = this.team2!.snapshotId;
    snapshot['schedule'] = Timestamp.fromDate(this.schedule);
    snapshot['bo'] = this.bo;
    snapshot['matchStreamUrl'] = this.matchStreamUrl;
    snapshot['like_count'] = this.likeCount;
    snapshot['view_count'] = this.viewCount;
    snapshot['share_count'] = this.shareCount;

    return snapshot;
  }

  Pair<bool, String> isStarted() {
    final diff = schedule.difference(DateTime.now());
    if (diff.inDays > 1) {
      final time = 'in ${diff.inDays} days';
      return Pair(false, time);
    } else if (diff.inHours > 9) {
      final time = 'in ${diff.inHours} hours';
      return Pair(false, time);
    } else if (diff.inMinutes > 1) {
      final inMinutes = diff.inMinutes;
      var time;
      if (inMinutes > 60) {
        var d = Duration(minutes: inMinutes);
        List<String> parts = d.toString().split(':');
        time = 'in ${parts[0].padLeft(2)} hours ${parts[1].padLeft(2)} minutes';
      } else {
        time = 'in ${diff.inMinutes} minutes';
      }

      return Pair(false, time);
    } else {
      return Pair(true, 'online');
    }
  }

  // @override
  // List<Object> get props => [image, name, snapshotId, gameCategoryId];
}
