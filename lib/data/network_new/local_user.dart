import 'package:cloud_firestore/cloud_firestore.dart';

class LocalUser {
  String? snapshotId;
  String? nickName;
  double? points;
  LocalUser();
  LocalUser.fromSnapshot(DocumentSnapshot snapshot) {
    this.snapshotId = snapshot.id;
    this.nickName = snapshot['nickName'];
    this.points = snapshot['points'];
  }
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> snapshot = new Map<String, dynamic>();
    snapshot['nickName'] = this.nickName;
    snapshot['points'] = this.points;
    return snapshot;
  }

}
