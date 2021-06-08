import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sport_news/data/network_new/game_category.dart';

class LocalTeam {
  GameCategory? gameCategory;
  String? gameCategoryId;
  String? name;
  String? image;
  String? snapshotId;
  String? imageUrl;

  LocalTeam();

  LocalTeam.fromSnapshot(DocumentSnapshot snapshot) {
    this.snapshotId = snapshot.id;
    this.image = snapshot['image'];
    this.name = snapshot['name'];
    this.gameCategoryId = snapshot['game_category_id'];
    this.imageUrl = snapshot['imageUrl'] ?? '';
    log(imageUrl.toString());
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['name'] = this.name;
    data['game_category_id'] = this.gameCategory!.snapshotID;
    data['imageUrl'] = this.imageUrl;
    return data;
  }

  @override
  List<Object?> get props => [image, name, snapshotId, gameCategoryId];
}
