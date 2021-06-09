import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class League extends Equatable {
  String? imageUrl;
  String? name;
  String? snapshotID;
  League();

  League.fromSnapshot(DocumentSnapshot snapshot) {
    this.snapshotID = snapshot.id;
    this.imageUrl = snapshot['image_url'];
    this.name = snapshot['name'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> snapshot = new Map<String, dynamic>();
    snapshot['image_url'] = this.imageUrl;
    snapshot['name'] = this.name;
    return snapshot;
  }

  @override
  List<Object?> get props => [
        name,
        snapshotID,
      ];
}
