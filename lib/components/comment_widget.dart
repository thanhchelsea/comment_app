import 'package:comment/components/image_custom.dart';
import 'package:comment/models/comment.dart';
import 'package:comment/utils/app_colors.dart';
import 'package:comment/utils/client_utils.dart';
import 'package:comment/utils/image_module.dart';
import 'package:comment/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
 
 typedef  onTap = Function(Comment c);
class CommentWidget extends StatelessWidget {
  Comment comment;
  onTap onTapLike;
  onTap? onTapReply;
  String uuIdMe;
  CommentWidget({
    Key? key,
    required this.comment,
    required this.onTapLike,
    required this.uuIdMe,
    this.onTapReply,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return itemComment(comment,showReply: onTapReply != null ? true : false );
  }

  Widget itemComment(Comment cmt,{bool showReply = true}) {
    return Container(
      padding: EdgeInsets.only(left: showReply ? 16 : 0, right: 16, top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          cmt.avatarUrl.isNotEmpty
              ? Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.teal,
                    shape: BoxShape.circle,
                  ),
                  child: ImageCustom.imageCache(
                    cmt.avatarUrl,
                  ),
                )
              : Container(
                  width: 35,
                  child: Image(
                    image: AssetImage(
                      AppImages.avatarDefault,
                      package: Configs.packageName,
                    ),
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cmt.userName,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: AppColors.blue9,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 6),
                  child: Text(
                    cmt.content,
                    style: TextStyle(
                        fontSize: 14,
                        color: AppColors.black0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            ClientUltil.convertDateComment(cmt.createdDate)
                                .toString(),
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.black0,
                        ),
                      ),
                      WidgetSpan(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: InkWell(
                              onTap: () {
                                onTapLike(cmt);
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Thích",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color:
                                          cmt.getLikes().contains(uuIdMe)
                                              ? AppColors.blue9
                                              : AppColors.black0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "${cmt.getLikes().isNotEmpty ? "(" + cmt.getLikes().length.toString() + ")" : ""} ",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.blue9,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                      showReply
                          ? WidgetSpan(
                              child: InkWell(
                                onTap: () {
                                  onTapReply!(cmt);
                                },
                                child: Text(
                                  "Trả lời ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.teal1,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            )
                          : WidgetSpan(child: Container()),
                    ],
                  ),
                ),
              replyComment(cmt),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget replyComment(Comment userCmt) {
     return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              userCmt.getReplies().isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        userCmt.getReplies().length,
                        (index) => Column(
                          children: [
                            itemComment(userCmt.getReplies()[index],
                                showReply: false),
                          ],
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
        );
  }

}
