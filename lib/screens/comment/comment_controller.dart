import 'dart:async';
import 'dart:convert';
import 'package:comment/models/index.dart';
import 'package:comment/service/index.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentController extends GetxController {
  TextEditingController textEditcontroller = TextEditingController();
  Rxn<Comment> commentSelected = Rxn<Comment>();
  Rxn<Comment> userMe = Rxn<Comment>();
  RxList<Comment> listComment = <Comment>[].obs;
  RxBool isLoading = false.obs;
  ScrollController scrollController = new ScrollController();
  RxInt limitLoad = 0.obs;

  late StreamSubscription<Event> _onPostAddedSubscription;
  late StreamSubscription<Event> _onPostChangedSubscription;

  void increaseLimitLoad() {
    limitLoad.value = limitLoad.value + 10;
  }

  selectComment(Comment comment) {
    commentSelected.value = comment;
  }

  removeCommentSelected() {
    commentSelected.value = null;
  }

  replyComment(String idQuestion) {
    if (textEditcontroller.text.isNotEmpty) {
      userMe.value!.content = textEditcontroller.text;
      // userMe.value!.createdDate= int.parse(ServerValue.timestamp.values.toString());
      Comment u = userMe.value!;
      u.parentId = commentSelected.value!.id;
      FireBaseConnect()
          .replyComment(
            idQuestion: idQuestion,
            commentSelected: commentSelected.value,
            userMe: u,
          )
          .then((value) => textEditcontroller.text = "");
    }
  }

  comment(String idQuestion) {
    if (textEditcontroller.text.isNotEmpty) {
      if (userMe.value!.parentId.isNotEmpty) {
        userMe.value!.parentId = "";
      }
      userMe.value!.content = textEditcontroller.text;
      FireBaseConnect()
          .addComment(idQuestion: idQuestion, comment: userMe.value)
          .then((value) {
        textEditcontroller.text = "";
        scrrolToBottom();
      });
    }
  }

  scrrolToBottom() {
    if (scrollController.positions.isNotEmpty) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  likeComment(String idQuestion, Comment comment) {
    FireBaseConnect().likeComment(
        idQuestion: idQuestion,
        commentSelect: comment,
        userId: userMe.value!.userId);
  }

  @override
  void onReady() {
    update();
    super.onReady();
  }

  Future getComment(String id) async {
    isLoading.value = true;
    limitLoad.value += 10;
    DataSnapshot dataSnapshot = await FireBaseConnect().getComment(
      id,
      limitLoad.value,
    );
    List<Comment> data = [];
    if (dataSnapshot.value != null) {
      Map<String, dynamic> result = Map<String, dynamic>.from(
          dataSnapshot.value as Map<dynamic, dynamic>);
      if (result.isNotEmpty) {
        result.forEach((key, value) {
          Map<String, dynamic> json = Map.from(value);
          Comment u = Comment.fromJson(json);
          data.add(u);
        });
        listComment.value = data;
      }
    }
    isLoading.value = false;
  }

  Future<void> initGetComment(String id, User user) async {
    userMe.value = Comment.init(
      userId: user.id,
      userName: user.name,
      avatarUrl: user.avatarUrl,
    );
    await getComment(id);
    // _onPostAddedSubscription = FirebaseDatabase.instance
    //     .reference()
    //     .child('comment/${id}')
    //     .limitToLast(1)
    //     .onChildAdded
    //     .listen((event) {
    //             Map<String, dynamic> json = Map.from(event.snapshot.value);
    //         Comment u = Comment.fromJson(json)..setId(event.snapshot.key ?? "");
    //  if(u.parentId.isEmpty){
    //    listComment.add(u);
    //  }else {
    //      listComment.forEach((element) {
    //         if (element.id == u.parentId) {
    //           element.addReplyComment(u);
    //         }
    //       });
    //  }
    // Comment u = Comment.fromSnapshot(event.snapshot);
    // // if (!data.contains(u))
    //   moveToReply(u, listComment);
    // //   update();
    // });
    _onPostChangedSubscription = FirebaseDatabase.instance
        .reference()
        .child('comment/${id}')
        //  .limitToLast(1)
        .onChildChanged
        .listen((event) {
      Map<String, dynamic> json = Map.from(event.snapshot.value);
      Comment u = Comment.fromJson(json);
      int indexWhere = listComment.indexWhere((element) => element.id == u.id);
      if (indexWhere == -1) {
        //cmt mới
        if (u.parentId.isEmpty) {
          listComment.add(u);
        } else {
          listComment.forEach((element) {
            if (element.id == u.parentId) {
              element.addReplyComment(u);
            }
          });
        }
      } else {
        // cập nhật cmt
        print("update cmt");
        if (u.parentId.isEmpty) {
          if (indexWhere >= 0) listComment[indexWhere] = u;
        } else {
          listComment.forEach((element) {
            if (element.id == u.parentId) {
              element.getReplies()[
                  element.getReplies().indexWhere((e1) => e1.id == u.id)] = u;
            }
          });
        }
      }
      update();
    });
  }

  @override
  void onClose() {
    //  textEditcontroller.dispose();
    _onPostChangedSubscription.cancel();
    // _onPostAddedSubscription.cancel();
    super.onClose();
  }
}
