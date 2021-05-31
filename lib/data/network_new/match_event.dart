import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sport_news/data/helper/pair.dart';
import 'package:sport_news/data/local/local_team.dart';
import 'package:sport_news/data/network_new/game_category.dart';

class MatchEvent {
  String snapshotId;
  LocalTeam team1;
  LocalTeam team2;
  DateTime schedule;
  int bo;
  String matchStreamUrl;

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
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> snapshot = new Map<String, dynamic>();
    snapshot['team1'] = this.team1.snapshotId;
    snapshot['team2'] = this.team2.snapshotId;
    snapshot['schedule'] = Timestamp.fromDate(this.schedule);
    snapshot['bo'] = this.bo;
    snapshot['matchStreamUrl'] = this.matchStreamUrl;
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
        time =
            'in ${parts[0].padLeft(2)} hours ${parts[1].padLeft(2)} minutes';
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
