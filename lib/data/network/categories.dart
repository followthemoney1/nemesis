import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCategories {
  String? key;
  String? iconPreview;
  String? iconUrl;
  String? idkey;
  String? imageUrl;
  String? title;

  FirebaseCategories(this.key, this.iconPreview, this.iconUrl, this.idkey,
      this.imageUrl, this.title);

  FirebaseCategories.fromSnapshot(DocumentSnapshot snapshot) {
    key = snapshot.id;
    //MARK: parse result list with random keys
    // iconPreview = snapshot.value["iconPreview"];
    // iconUrl = snapshot.value["iconUrl"];
    // idkey = snapshot.value["idkey"];
    // imageUrl = snapshot.value["imageUrl"];
    // title = snapshot.value["title"];

//    Map<dynamic, dynamic> resultList = snapshot.value;
//    resultList.forEach((key, value) {
//      langGroup.add(LangGroup(key, value));
//    });
  }
}
