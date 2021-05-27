import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class GameCategory extends Equatable {
  String id;
  String name;
  String snapshotID;
  GameCategory();
  
  GameCategory.fromSnapshot(DocumentSnapshot snapshot) {
    this.snapshotID = snapshot.id;
    this.id = snapshot['id'];
    this.name = snapshot['name'];
  }

  @override
  List<Object> get props => [
        id,
        name,
        snapshotID,
      ];
}
