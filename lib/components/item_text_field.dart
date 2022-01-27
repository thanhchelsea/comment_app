import 'dart:math';
import 'package:comment/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TextFieldCustom extends StatelessWidget {
  TextEditingController controller;
  bool enable;
  Function? oncChange;
  Function onSend;

  TextFieldCustom({
   required this.controller,
    required this.enable,
    required this.oncChange,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.black3.withOpacity(0.5))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              enabled: enable,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Bình luận...",
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
              onChanged: (value) {
                String text = value.trim();
               if(oncChange!=null) oncChange!();
              },
            ),
          ),
          itemSend(),
        ],
      ),
    );
  }

  Widget itemSend() {
    return Container(
      child: InkWell(
        onTap: () async {
          onSend();
        },
        child: Icon(
          FontAwesomeIcons.paperPlane,
          color: AppColors.green5,
        ),
      ),
    );
  }
}
