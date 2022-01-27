import 'package:comment/components/comment_widget.dart';
import 'package:comment/components/item_text_field.dart';
import 'package:comment/models/index.dart';
import 'package:comment/models/user.dart';
import 'package:comment/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'comment_controller.dart';

class CommentUi extends StatefulWidget {
  String id;
  User user;
  CommentUi({required this.id,required this.user});
  @override
  _CommentUiState createState() => _CommentUiState();
}

class _CommentUiState extends State<CommentUi> {
  late double width, height;
  var cmtController = Get.find<CommentController>();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      cmtController.initGetComment(widget.id,widget.user);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = Get.width;
    height = Get.height;
    // return Container(
    //   child: Text("comment app "),
    // );
    return Scaffold(
      body: GetX<CommentController>(
        builder: (controller) {
          return Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                height: height,
                // padding: EdgeInsets.only(bottom: width * 0.123),
                child: controller.listComment.isNotEmpty
                    ? RefreshIndicator(
                      onRefresh: ()async{
                        controller.getComment(widget.id);
                      },
                      child: ListView(
                          controller: controller.scrollController,
                          padding: EdgeInsets.only(bottom: width * 0.2),
                          children: List.generate(
                            controller.listComment.length,
                            (index) => Column(
                              children: [
                                CommentWidget(
                                  comment: controller.listComment[index],
                                  uuIdMe: controller.userMe.value!.userId,
                                  onTapLike: (cmt) {
                                    controller.likeComment(widget.id, cmt);
                                  },
                                  onTapReply: (cmt) {
                                    controller.selectComment(cmt);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                    )
                    : Container(),
              ),
              Positioned(
                bottom: 0,
                // left: 0,
                child: Container(
                  padding: EdgeInsets.all(16),
                  width: width,
                  color: AppColors.white0,
                  child: itemInput(controller),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget itemInput(CommentController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        controller.commentSelected.value != null
            ? Container(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: "Trả lời: ",
                          style: TextStyle(
                            color: AppColors.black3,
                            fontWeight: FontWeight.w600,
                          )),
                      TextSpan(
                        text: controller.commentSelected.value!.userName,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.blue9,
                        ),
                      ),
                      WidgetSpan(
                        child: Container(
                          padding: EdgeInsets.only(left: 4),
                          child: InkWell(
                            child: Icon(
                              FontAwesomeIcons.times,
                              size: 18,
                            ),
                            onTap: () {
                              controller.removeCommentSelected();
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 4),
              )
            : Container(),
        TextFieldCustom(
            controller: controller.textEditcontroller,
            enable: true,
            oncChange: () {},
            onSend: () {
              if (controller.commentSelected.value != null) {
                controller.replyComment(widget.id);
              } else {
                controller.comment(widget.id);
              }
            }),
      ],
    );
  }

  // Widget itemComment(Comment userCmt, {bool showReply = true}) {
  //   return Container(
  //     padding: EdgeInsets.only(left: showReply ? 16 : 0, right: 16, top: 16),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         userCmt.avatarUrl.isNotEmpty
  //             ? Container(
  //                 padding: EdgeInsets.all(6),
  //                 decoration: BoxDecoration(
  //                   color: AppColors.teal,
  //                   shape: BoxShape.circle,
  //                 ),
  //                 child: ImageCustom.imageCache(
  //                   userCmt.avatarUrl,
  //                 ),
  //               )
  //             : Container(
  //                 width: width * 0.05,
  //                 child: Image(
  //                   image: AssetImage(
  //                     AppImages.avatarDefault,
  //                     package: Configs.packageName,
  //                   ),
  //                 ),
  //                 decoration: BoxDecoration(
  //                   shape: BoxShape.circle,
  //                 ),
  //               ),
  //         SizedBox(width: 10),
  //         Expanded(
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 userCmt.userName,
  //                 style: TextStyle(
  //                   fontSize: 15,
  //                   fontWeight: FontWeight.w800,
  //                   color: AppColors.blue9,
  //                 ),
  //               ),
  //               Text(
  //                 userCmt.content,
  //                 style: TextStyle(
  //                     fontSize: 14,
  //                     color: AppColors.black0,
  //                     fontWeight: FontWeight.w500),
  //               ),
  //               RichText(
  //                 text: TextSpan(
  //                   children: [
  //                     TextSpan(
  //                       text:
  //                           ClientUltil.convertDateComment(userCmt.createdDate)
  //                               .toString(),
  //                       style: TextStyle(
  //                         fontSize: 12,
  //                         color: AppColors.black0,
  //                       ),
  //                     ),
  //                     WidgetSpan(
  //                       child: Container(
  //                         padding: EdgeInsets.symmetric(horizontal: 6),
  //                         child: InkWell(
  //                             onTap: () {
  //                               cmtController.likeComment(widget.id, userCmt);
  //                             },
  //                             child: Row(
  //                               mainAxisSize: MainAxisSize.min,
  //                               children: [
  //                                 Text(
  //                                   "Thích",
  //                                   style: TextStyle(
  //                                     fontSize: 12,
  //                                     color:
  //                                         userCmt.getLikes().contains("uuidMe")
  //                                             ? AppColors.teal1
  //                                             : AppColors.black,
  //                                     fontWeight: FontWeight.w600,
  //                                   ),
  //                                 ),
  //                                 Container(
  //                                   child: Text(
  //                                     "${userCmt.getLikes().isNotEmpty ? "(" + userCmt.getLikes().length.toString() + ")" : ""} ",
  //                                     style: TextStyle(
  //                                       fontSize: 12,
  //                                       color: AppColors.blue9,
  //                                       fontWeight: FontWeight.w600,
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ],
  //                             )),
  //                       ),
  //                     ),
  //                     showReply
  //                         ? WidgetSpan(
  //                             child: InkWell(
  //                               onTap: () {
  //                                 cmtController.selectComment(userCmt);
  //                               },
  //                               child: Text(
  //                                 "Trả lời ",
  //                                 style: TextStyle(
  //                                   fontSize: 12,
  //                                   color: AppColors.teal1,
  //                                   fontWeight: FontWeight.w600,
  //                                 ),
  //                               ),
  //                             ),
  //                           )
  //                         : WidgetSpan(child: Container()),
  //                   ],
  //                 ),
  //               ),
  //               replyComment(userCmt),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget replyComment(Comment userCmt) {
  //   return GetBuilder<CommentController>(
  //     builder: (controller) {
  //       return Container(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             userCmt.getReplies().isNotEmpty
  //                 ? Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: List.generate(
  //                       userCmt.getReplies().length,
  //                       (index) => Column(
  //                         children: [
  //                           itemReplyComment(userCmt.getReplies()[index],
  //                               showReply: false),
  //                         ],
  //                       ),
  //                     ),
  //                   )
  //                 : Container()
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  // Widget itemReplyComment(Comment userCmt, {bool showReply = true}) {
  //   return Container(
  //     padding: EdgeInsets.only(left: showReply ? 16 : 0, right: 16, top: 8),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         userCmt.avatarUrl.isNotEmpty
  //             ? Container(
  //                 padding: EdgeInsets.all(6),
  //                 decoration: BoxDecoration(
  //                   color: AppColors.teal,
  //                   shape: BoxShape.circle,
  //                 ),
  //                 child: ImageCustom.imageCache(userCmt.avatarUrl),
  //               )
  //             : Container(
  //                 width: width * 0.05,
  //                 child: Image(
  //                   image: AssetImage(
  //                     AppImages.avatarDefault,
  //                     package: Configs.packageName,
  //                   ),
  //                 ),
  //                 decoration: BoxDecoration(
  //                   shape: BoxShape.circle,
  //                 ),
  //               ),
  //         SizedBox(width: 10),
  //         Expanded(
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 userCmt.userName,
  //                 style: TextStyle(
  //                   fontSize: 15,
  //                   fontWeight: FontWeight.w800,
  //                   color: AppColors.blue9,
  //                 ),
  //               ),
  //               Text(
  //                 userCmt.content,
  //                 style: TextStyle(
  //                   fontSize: 14,
  //                   color: AppColors.black,
  //                 ),
  //               ),
  //               RichText(
  //                 text: TextSpan(
  //                   children: [
  //                     TextSpan(
  //                       text:
  //                           ClientUltil.convertDateComment(userCmt.createdDate)
  //                               .toString(),
  //                       style: TextStyle(
  //                         fontSize: 12,
  //                         color: AppColors.black0,
  //                       ),
  //                     ),
  //                     WidgetSpan(
  //                       child: Container(
  //                         padding: EdgeInsets.symmetric(horizontal: 6),
  //                         child: InkWell(
  //                             onTap: () {
  //                               cmtController.likeComment(widget.id, userCmt);
  //                             },
  //                             child: Row(
  //                               mainAxisSize: MainAxisSize.min,
  //                               children: [
  //                                 Text(
  //                                   "Thích",
  //                                   style: TextStyle(
  //                                     fontSize: 12,
  //                                     color:
  //                                         userCmt.getLikes().contains("uudiMe")
  //                                             ? AppColors.teal1
  //                                             : AppColors.black0,
  //                                     fontWeight: FontWeight.w600,
  //                                   ),
  //                                 ),
  //                                 Container(
  //                                   child: Text(
  //                                     "${userCmt.getLikes().isNotEmpty ? "(" + userCmt.getLikes().length.toString() + ")" : ""} ",
  //                                     style: TextStyle(
  //                                       fontSize: 12,
  //                                       color: AppColors.blue9,
  //                                       fontWeight: FontWeight.w600,
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ],
  //                             )),
  //                       ),
  //                     ),
  //                     showReply
  //                         ? WidgetSpan(
  //                             child: InkWell(
  //                               onTap: () {
  //                                 cmtController.selectComment(userCmt);
  //                               },
  //                               child: Text(
  //                                 "Trả lời ",
  //                                 style: TextStyle(
  //                                   fontSize: 12,
  //                                   color: AppColors.blue,
  //                                 ),
  //                               ),
  //                             ),
  //                           )
  //                         : WidgetSpan(child: Container()),
  //                   ],
  //                 ),
  //               ),
  //               replyComment(userCmt),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }


}
