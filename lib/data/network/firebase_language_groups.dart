import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseLanguagesGroups {
  String? key;
  List<LangGroup>? langGroup;

  FirebaseLanguagesGroups(this.key, this.langGroup);

  FirebaseLanguagesGroups.fromSnapshot(DocumentSnapshot snapshot) {
    // key = snapshot.key;
    // //MARK: parse result list with random keys
    // langGroup = List();
    // Map<dynamic, dynamic> resultList = snapshot.value;
    // resultList.forEach((key, value) {
    //   langGroup.add(LangGroup(key, value));
    // });
  }
}

class LangGroup {
  String key;
  bool val;

  LangGroup(this.key, this.val);
}
