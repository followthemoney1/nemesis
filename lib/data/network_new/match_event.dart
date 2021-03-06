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
  String? leagueId;
  String? categoryId;
  List<Placed> placed = [];
  List<Totals> totals = [];
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
    this.leagueId = snapshot.hasKey('league_id') ? snapshot['league_id'] : null;
    this.categoryId =
        snapshot.hasKey('category_id') ? snapshot['category_id'] : null;
    log(likeCount.toString());

    if (snapshot.hasKey("totals") && ['totals'] != null) {
      snapshot['totals'].forEach((v) {
        totals.add(new Totals.fromJson(v));
      });
    }

    if (snapshot.hasKey("placed") && snapshot['placed'] != null) {
      snapshot['placed'].forEach((v) {
        placed.add(new Placed.fromJson(v));
      });
    }
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
    snapshot['league_id'] = this.leagueId;
    snapshot['category_id'] = this.categoryId;
    //mark ;totals
    if (this.totals != null && this.totals.isNotEmpty) {
    } else {
      final t1 = Totals()
        ..onTeamId = this.team1!.snapshotId
        ..placedTotalCof = 0
        ..placedTotalSum = 0;
      this.totals.add(t1);
      final t2 = Totals()
        ..onTeamId = this.team2!.snapshotId
        ..placedTotalCof = 0
        ..placedTotalSum = 0;
      this.totals.add(t2);
    }
    snapshot['totals'] = this.totals.map((v) => v.toJson()).toList();
    //mark: placed
    if (this.placed != null && this.placed.isNotEmpty) {
      snapshot['placed'] = this.placed.map((v) => v.toJson()).toList();
    } else {
      snapshot['placed'] = [];
    }

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

  bool checkIfAnyIsNull() {
    return [
      team1,
      team2,
      bo,
      matchStreamUrl,
      schedule,
      likeCount,
      viewCount,
      shareCount,
      leagueId,
      categoryId
    ].contains(null);
  }

  Totals? getTotalOnTeam({required String teamId}){
   return this.totals.firstWhere((element) => element.onTeamId == teamId);
  }

  // @override
  // List<Object> get props => [team1, team2, bo, matchStreamUrl,schedule,likeCount,viewCount,shareCount,leagueId,categoryId];
}

class Placed {
  String? userId;
  double? place;
  String? onTeamId;

  Placed({this.userId, this.place, this.onTeamId});

  Placed.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    place = json['place'];
    onTeamId = json['onTeamId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['place'] = this.place;
    data['onTeamId'] = this.onTeamId;
    return data;
  }
}

class Totals {
  String? onTeamId;
  double? placedTotalSum;
  double? placedTotalCof;

  Totals({this.onTeamId, this.placedTotalSum, this.placedTotalCof});

  Totals.fromJson(Map<String, dynamic> json) {
    onTeamId = json['on_team_id'];
    placedTotalSum = json['placed_total_sum'];
    placedTotalCof = json['placed_total_cof'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['on_team_id'] = this.onTeamId;
    data['placed_total_sum'] = this.placedTotalSum;
    data['placed_total_cof'] = this.placedTotalCof;
    return data;
  }
}
