// import 'package:firebase_database/firebase_database.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseLanguages {
  String language;
  String groupKey;
  FirebaseLanguages({this.language, this.groupKey});

  // FirebaseLanguages.fromSnapshot(DocumentSnapshot snapshot)
  //     : language = snapshot.value["language"],
  //       groupKey = snapshot.value["group_key"];

  FirebaseLanguages.fromMap(Map<dynamic, dynamic> snapshot)
      : language = snapshot["language"],
        groupKey = snapshot["group_key"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language'] = this.language;
    return data;
  }
}
