// 'idFrom': id,
//           'idTo': peerId,
//           'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
//           'content': content,
//           'type': type

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ChatMessage {
  String? idFrom ='';
  String? idTo='';
  String? snapshotID;
  DateTime? timestamp;
  String? content;
  String? type = 'message';
  ChatMessage();

  ChatMessage.fromSnapshot(DocumentSnapshot snapshot) {
    this.snapshotID = snapshot.id;
    this.idFrom = snapshot['id_from'];
    this.idTo = snapshot['id_to'];
    this.timestamp = (snapshot['timestamp'] as Timestamp).toDate();
    this.content = snapshot['content'];
    this.type = 'type';
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> snapshot = new Map<String, dynamic>();

    snapshot['id_from'] = this.idFrom;
    snapshot['id_to'] = this.idTo;
    snapshot['timestamp'] =
        Timestamp.fromDate(this.timestamp ?? DateTime.now());
    snapshot['content'] = this.content;
    snapshot['type'] = this.type;
    return snapshot;
  }
}
