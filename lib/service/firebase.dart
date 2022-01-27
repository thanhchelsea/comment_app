import 'dart:async';
import 'package:comment/models/index.dart';
import 'package:firebase_database/firebase_database.dart';

class FireBaseConnect {
  final databaseReference = FirebaseDatabase.instance.reference();
  final String collection = "comment";

  Future<DataSnapshot> getComment(String id, int limitLoad) async {
    DataSnapshot data = await databaseReference
        .child('$collection/$id')
        .limitToLast(limitLoad)
        .once();
    return data;
  }

  Future<void> addComment(
      {required String idQuestion, Comment? comment}) async {
    print("add comment");
    int timeId = DateTime.now().microsecondsSinceEpoch;
    databaseReference
        .child("$collection/${idQuestion}")
        .child("${timeId}")
        .set(comment!.toJson(timeId));
  }

  Future<void> likeComment(
      {required String idQuestion,
      Comment? commentSelect, required String userId}) async {
    if (commentSelect!.getLikes().contains(userId)) {
      commentSelect.getLikes().remove(userId);
    } else {
      commentSelect.getLikes().add(userId);
    }

    if (commentSelect.parentId.isNotEmpty) {
      databaseReference
          .child("$collection/${idQuestion}")
          .child(commentSelect.parentId)
          .child("replies")
          .child(commentSelect.id)
          .child("likes")
          .set(commentSelect.getLikes());
    }else {
           databaseReference
          .child("$collection/$idQuestion")
          .child(commentSelect.id)
          .child("likes")
          .set(commentSelect.getLikes());
    }
  }

  Future<void> replyComment(
      {required String idQuestion,
      Comment? commentSelected,
      Comment? userMe}) async {
            int timeId = DateTime.now().microsecondsSinceEpoch;

    databaseReference
        .child("$collection/$idQuestion")
       .child(commentSelected!.id)
       .child("replies")
        .child("${timeId}")
        .set(userMe!.toJson(timeId));
  }

  Future<int> countComment({required String idQuestion}) async {
    int count = 0;
    await databaseReference.child("$collection/$idQuestion").get().then(
      (event) {
        if (event.value != null) {
          count = event.value.length;
        }
      },
    );
    return Future.value(count);
  }
}
