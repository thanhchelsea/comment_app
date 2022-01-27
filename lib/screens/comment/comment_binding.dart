import 'package:get/get.dart';

import 'comment_controller.dart';

class CommentBindings extends Bindings{
  @override
  void dependencies() {
    Get.put<CommentController>(CommentController());
  }

}