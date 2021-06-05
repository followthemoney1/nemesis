import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseGroupNews {
  String? group;
  String? icon;
  String? key;
  List<FirebaseGroup>? groupList;
  List<FirebaseGroup>? categoryList;

  FirebaseGroupNews(this.key, this.group, this.icon, this.groupList);

  FirebaseGroupNews.fromSnapshot(DocumentSnapshot snapshot) {
    // key = snapshot.key;
    // icon = snapshot.value["icon"];
    // group = snapshot.value["group"];

    // //MARK: parse result list with random keys
    // groupList = List();
    // categoryList = List();
    // Map<dynamic, dynamic> groupResultList = snapshot.value["news"];
    // if (groupResultList != null && groupResultList.length > 0) {
    //   groupResultList.forEach((key, value) {
    //     groupList.add(FirebaseGroup(key, value));
    //   });
    // }

    // Map<dynamic, dynamic> categoryResultList = snapshot.value["categories"];
    // if (categoryResultList != null && categoryResultList.length > 0) {
    //   categoryResultList.forEach((key, value) {
    //     categoryList.add(FirebaseGroup(key, value));
    //   });
    // }
  }
}

class FirebaseGroup {
  String key;
  dynamic val;

  FirebaseGroup(this.key, this.val);
}
