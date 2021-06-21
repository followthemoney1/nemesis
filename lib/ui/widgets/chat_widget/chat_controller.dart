import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sport_news/data/network_new/chat_message.dart';
import 'package:sport_news/managers/firebase_manager.dart';

class ChatController extends GetxController {
  FirebaseManager firebaseManager = Get.find<FirebaseManager>();
  String matchId;
  ChatController({required this.matchId});
  RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final TextEditingController editingController = TextEditingController();

  // Timer? _debounce;
  bool canSendMessage = true;
  // String get timeToSend => (10000 - _debounce!.tick!.milliseconds.inMilliseconds).toString();
  @override
  void onInit() {
    subscribeToChat();
    super.onInit();
  }

  subscribeToChat() {
    final querySnapshot = firebaseManager.subscribeToChat(
      matchId: matchId,
    );
    querySnapshot.listen((event) {
      messages.clear();
      event.docs.forEach((snap) {
        final chatMessage = ChatMessage.fromSnapshot(snap);
        messages.add(chatMessage);
      });
      update();
    });
  }

  sendMessage(
      // required String message,
      ) async {
    final message = editingController.text;
    if (message == null || !canSendMessage) {
      return;
    }

    final chatMessage = ChatMessage()
      ..idFrom = firebaseManager.auth.currentUser!.uid
      ..content = message;

    await firebaseManager.sendMessage(matchId: matchId, message: chatMessage);
    canSendMessage = false;
    updateDebounce();
    log('message sendded');
  }

  bool showSendMessage() {
    final uid = firebaseManager.auth.currentUser?.uid;
    return uid != null;
  }

  updateDebounce() {
    // if (_debounce?.isActive ?? false) _debounce!.cancel();
    final t = Stream.periodic(Duration(microseconds: 100), (i) {
      canSendMessage = false;
      editingController.text =
          "Delay mode is ON. Snoozed for 10 seconds ";
    });
    t.take(1000).forEach((e) {
      print(e);
    }).then((value){
       canSendMessage = true;
      editingController.clear();

      update();
    }
    );

    // _debounce = Timer(const Duration(seconds: 10), () {
     
    // });
  }

  @override
  void onClose() {
    // _debounce!.cancel();
    super.onClose();
  }
}
