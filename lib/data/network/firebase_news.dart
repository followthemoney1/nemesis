import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:sport_news/pr_extension.dart';

class FirebaseNews {
  String key;
  String title;
  String channelId;
  String channelKey;
  String channelType;
  String creationDate;
  DateTime timeStamp;
  String groupKey;
  bool isPublished;
  String text;
  int likeCount;
  List<FirebaseImagesNews> images = [];
  String heroName;
  int articleClicked;
  int articleClickedAndroid;
  int articleClickedIOS;

  bool likedByUserTemp = false;
  String categoryKey;
  bool isWebView;
  String source;
  String webViewUrl;
  int webViewShowTime;
  int webViewClicked;
  int webViewClickedAndroid;
  int webViewClickedIOS;
  bool isViewed;
  String channelName;
  FirebaseNews(
      this.key,
      this.title,
      this.channelId,
      this.channelKey,
      this.channelType,
      this.groupKey,
      this.isPublished,
      this.text,
      this.source,
      this.likeCount,
      this.isWebView,
      this.categoryKey,
      {this.isViewed,
      this.articleClicked,
      this.channelName,
      this.webViewClicked,
      this.webViewClickedAndroid,
      this.webViewClickedIOS,
      this.webViewShowTime,
      this.webViewUrl});

  FirebaseNews.fromSnapshot(DocumentSnapshot snapshot) {
    // if (snapshot == null || snapshot.value == null) return;

    // key = snapshot.key;
    // title = snapshot.value["title"] ?? "";
    // channelId = snapshot.value["channel_id"] ?? "";
    // channelKey = snapshot.value["channel_key"] ?? "";
    // channelType = snapshot.value["channel_type"] ?? "";
    // likeCount = snapshot.value["like_count"] ?? 0;
    // isWebView = snapshot.value["isWebView"] ?? false;
    // groupKey = snapshot.value["group_key"] ?? "";
    // isPublished = snapshot.value["isPublished"] != null
    //     ? snapshot.value["isPublished"]
    //     : false;
    // text = snapshot.value["text"] ?? "";
    // categoryKey = snapshot.value["category_key"] ?? "";
    // source = snapshot.value["source"] ?? "";
    // isViewed = snapshot.value['isViewed'] ?? false;
    // webViewClicked = snapshot.value['webViewClicked'] ?? 0;
    // webViewClickedAndroid = snapshot.value['webViewClickedAndroid'] ?? 0;
    // webViewClickedIOS = snapshot.value['webViewClickedIOS'] ?? 0;

    // //webViewShowTime = snapshot.value['webViewShowTime'] ?? 0;
    // webViewUrl = snapshot.value['webViewUrl'] ?? '';
    // channelName = snapshot.value['channelName'] ?? '';
    // articleClicked = snapshot.value['articleClicked'] ?? 0;
    // articleClickedAndroid = snapshot.value['articleClickedAndroid'] ?? 0;
    // articleClickedIOS = snapshot.value['articleClickedIOS'] ?? 0;

    // //mark: date of creation
    // try {
    //   timeStamp =
    //       DateTime.fromMillisecondsSinceEpoch(snapshot.value["creation_date"]);
    // } catch (e) {
    //   timeStamp = DateTime.now();
    // }
    // creationDate = "${timeStamp.day}\.${timeStamp.month}\.${timeStamp.year}";
    // //mark: images
    // if (snapshot.value["images"] != null) {
    //   Map<dynamic, dynamic> resultList = snapshot.value["images"];
    //   resultList.forEach((key, value) {
    //     final image = FirebaseImagesNews(key.toString(), value["url"]);
    //     images.add(image);
    //   });
    // }

    // heroName = ((groupKey + text + channelType + key) +
    //         Random().nextInt(10000).toString())
    //     .trimSpaceAndLCase();
    // if (heroName == null)
    //   heroName = Random().nextInt(60000).toString().trimSpaceAndLCase();
  }

  FirebaseNews.fromMap({Map<dynamic, dynamic> snapshot, String k}) {
    if (snapshot == null) return;
    key = k;
    title = snapshot["title"] ?? "";
    channelId = snapshot["channel_id"] ?? "";
    channelKey = snapshot["channel_key"] ?? "";
    channelType = snapshot["channel_type"] ?? "";
    likeCount = snapshot["like_count"] ?? 0;
    categoryKey = snapshot["category_key"] ?? "";
    isWebView = snapshot["isWebView"] ?? false;
    articleClicked = snapshot['articleClicked'] ?? 0;
    articleClickedAndroid = snapshot['articleClickedAndroid'] ?? 0;
    articleClickedIOS = snapshot['articleClickedIOS'] ?? 0;
    webViewUrl = snapshot['webViewUrl'] ?? '';
    webViewClicked = snapshot['webViewClicked'] ?? 0;
    webViewClickedAndroid = snapshot['webViewClickedAndroid'] ?? 0;
    webViewClickedIOS = snapshot['webViewClickedIOS'] ?? 0;
    isViewed = snapshot['isViewed'] ?? false;
    groupKey = snapshot["group_key"] ?? "";
    isPublished =
        snapshot["isPublished"] != null ? snapshot["isPublished"] : false;
    text = snapshot["text"] ?? "";
    source = snapshot["source"] ?? "";
    channelName = snapshot['channelName'] ?? '';

    try {
      timeStamp =
          DateTime.fromMillisecondsSinceEpoch(snapshot["creation_date"]);
    } catch (e) {
      timeStamp = DateTime.now();
    }
    creationDate = "${timeStamp.day}\.${timeStamp.month}\.${timeStamp.year}";

    if (snapshot["images"] != null) {
      Map<dynamic, dynamic> resultList = snapshot["images"];
      resultList.forEach((key, value) {
        final image = FirebaseImagesNews(key.toString(), value["url"]);
        images.add(image);
      });
    }

    heroName = (groupKey +
            text +
            channelType +
            key +
            Random().nextInt(10000).toString())
        .trimSpaceAndLCase();
    if (heroName == null)
      heroName = Random().nextInt(60000).toString().trimSpaceAndLCase();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["title"] = title;
    data["channel_id"] = channelId;
    data["channel_key"] = channelKey;
    data["channel_type"] = channelType;
    data["like_count"] = likeCount;
    data["category_key"] = categoryKey;
    data["isWebView"] = isWebView;
    data['articleClicked'] = articleClicked;
    data['webViewUrl'] = webViewUrl;
    data['webViewClicked'] = webViewClicked;
    data['webViewClickedAndroid'] = webViewClickedAndroid;
    data['webViewClickedIOS'] = webViewClickedIOS;
    data['isViewed'] = isViewed;
    data["group_key"] = groupKey;
    data["isPublished"] = isPublished;
    data["text"] = text;
    data["source"] = source;
    data['channelName'] = channelName;
    data['articleClickedAndroid'] = articleClickedAndroid;
    data['articleClickedIOS'] = articleClickedIOS;
    return data;
  }
}

class FirebaseImagesNews {
  String key;
  String url;

  FirebaseImagesNews(this.key, this.url);
}
