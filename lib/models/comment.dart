import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:comment/models/index.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class Comment {
  String id = "";

  String parentId = "";

  String userId = "";

  String userName = "";

  String avatarUrl = "";

  int createdDate = 0;

  String content = "";

  List<String>? likes;

  List<Comment>? replies;

  int type = 0;

  List<String>? urlImage;

  String rootId = "";

  String rootType = "";
  Comment({
    required this.id,
    required this.parentId,
    required this.userId,
    required this.userName,
    required this.avatarUrl,
    required this.createdDate,
    required this.content,
    this.likes,
    required this.replies,
    required this.type,
    required this.urlImage,
    required this.rootId,
    required this.rootType,
  });

  factory Comment.init({
    String? id,
    String? parentId,
    String? userId,
    String? userName,
    String? avatarUrl,
    int? createdDate,
    String? content,
    List<String>? likes,
    List<Comment>? replies,
    int? type,
    List<String>? urlImage,
    String? rootId,
    String? rootType,
  }) {
    return Comment(
      id: id ?? "",
      parentId: parentId ?? "",
      userId: userId ?? "",
      userName: userName ?? "",
      avatarUrl: avatarUrl ?? "",
      createdDate: createdDate ?? 0,
      content: content ?? "",
      likes: likes ?? [],
      replies: replies ?? [],
      type: type ?? 0,
      urlImage: urlImage ?? [],
      rootId: rootId ?? "",
      rootType: rootType ?? "",
    );
  }
  List<Comment> getReplies() {
    if (replies == null) replies = [];
    return replies!;
  }

  List<String> getLikes() {
    return likes ?? [];
  }

  // UserComment.fromSnapshot(DataSnapshot snapshot)
  //     : id = snapshot.key ?? "",
  //       userId = snapshot.value['userId'] as String? ?? '',
  //       userName = snapshot.value['userName'] as String? ?? '',
  //       avatarUrl = snapshot.value['avatarUrl'] as String? ?? '',
  //       timeComment = snapshot.value['timeComment'] ?? 0,
  //       contentComment = snapshot.value['contentComment'] as String? ?? '',
  //       parentId = snapshot.value['parentId'] as String? ?? '',
  //       like = (snapshot.value['likes'] as List<dynamic>?)
  //               ?.map((e) => e as String)
  //               .toList() ??
  //           [];

  void setId(String key) {
    id = key;
  }

  void addReplyComment(Comment reply) {
    getReplies().add(reply);
  }

  Comment copyWith({
    String? id,
    String? parentId,
    String? userId,
    String? userName,
    String? avatarUrl,
    int? createdDate,
    String? content,
    List<String>? likes,
    //  List<Comment>? replies,
    int? type,
    List<String>? urlImage,
    String? rootId,
    String? rootType,
  }) {
    return Comment(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      createdDate: createdDate ?? this.createdDate,
      content: content ?? this.content,
      likes: likes ?? this.likes,
      replies: replies ?? this.replies,
      type: type ?? this.type,
      urlImage: urlImage ?? this.urlImage,
      rootId: rootId ?? this.rootId,
      rootType: rootType ?? this.rootType,
    );
  }

  Map<String, dynamic> toMap(int timeId) {
    return {
      'id': '${timeId}',
      'parentId': parentId,
      'userId': userId,
      'userName': userName,
      'avatarUrl': avatarUrl,
      'createdDate': ServerValue.timestamp,
      'content': content,
      'likes': likes,
      //'replies': replies?.map((x) => x.toMap()).toList(),
      'type': type,
      'urlImage': urlImage,
      'rootId': rootId,
      'rootType': rootType,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    List<Comment> data = [];
    if (map['replies'] != null) {
      Map<String, dynamic> result =
          Map<String, dynamic>.from(map['replies'] as Map<dynamic, dynamic>);
      if (result.isNotEmpty) {
        result.forEach((key, value) {
          Map<String, dynamic> json = Map.from(value);
          Comment u = Comment.fromJson(json);
          // u.setKeyUnique(key);
          data.add(u);
        });
      }
    }

    return Comment(
      id: map['id'] != null ? map['id'].toString() : '',
      parentId: map['parentId'] ?? '',
      userId: map['userId'] ?? '',
      userName: map['userName'] ?? '',
      avatarUrl: map['avatarUrl'] ?? '',
      createdDate: map['createdDate']?.toInt() ?? 0,
      content: map['content'] ?? '',
      likes: map['likes'] != null ? List<String>.from(map['likes']) : [],
      replies: map['replies'] != null ? data : null,
      type: map['type']?.toInt() ?? 0,
      urlImage:
          map['urlImage'] != null ? List<String>.from(map['urlImage']) : [],
      rootId: map['rootId'] ?? '',
      rootType: map['rootType'] ?? '',
    );
  }

  Map<String, dynamic> toJson(int timeId) => toMap(timeId);

  factory Comment.fromJson(Map<String, dynamic> json) => Comment.fromMap(json);

  @override
  String toString() {
    return 'Comment(id: $id, parentId: $parentId, userId: $userId, userName: $userName, avatarUrl: $avatarUrl, createdDate: $createdDate, content: $content, likes: $likes, replies: $replies, type: $type, urlImage: $urlImage, rootId: $rootId, rootType: $rootType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Comment &&
        other.id == id &&
        other.parentId == parentId &&
        other.userId == userId &&
        other.userName == userName &&
        other.avatarUrl == avatarUrl &&
        other.createdDate == createdDate &&
        other.content == content &&
        listEquals(other.likes, likes) &&
        listEquals(other.replies, replies) &&
        other.type == type &&
        listEquals(other.urlImage, urlImage) &&
        other.rootId == rootId &&
        other.rootType == rootType;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        parentId.hashCode ^
        userId.hashCode ^
        userName.hashCode ^
        avatarUrl.hashCode ^
        createdDate.hashCode ^
        content.hashCode ^
        likes.hashCode ^
        replies.hashCode ^
        type.hashCode ^
        urlImage.hashCode ^
        rootId.hashCode ^
        rootType.hashCode;
  }
}
