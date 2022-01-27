import 'dart:io';
import 'package:intl/intl.dart';

class ClientUltil{
    static String convertDateComment(int date) {
    String time = "";
    int toDayDate = DateTime.now().millisecondsSinceEpoch;
    double second = toDayDate / 1000 - date / 1000;
    if (second < 60) {
      time = "1 phút trước";
    } else if (second >= 60 && second < 60 * 60) {
      int minute = second ~/ 60;
      time = "$minute phút trước";
    } else if (second >= 60 * 60 && second < 24 * 60 * 60) {
      int hour = second ~/ (60 * 60);
      int minute = (second % (60 * 60)) ~/ 60;
      time = "$hour giờ trước";
    } else {
      DateTime t = DateTime.fromMillisecondsSinceEpoch(date);
      String formattedDate = DateFormat('dd/MM/yyyy').format(t);
      time = formattedDate;
    }
    return time;
  }
}