
import 'package:cached_network_image/cached_network_image.dart';
import 'package:comment/utils/index.dart';
import 'package:flutter/material.dart';


class ImageCustom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }


  static Widget imageCache(
    String url, {
    double? width,
    double? height,
    bool fitCover = false,
    bool tapZoom = false,
  }) {
    return CachedNetworkImage(
        filterQuality: FilterQuality.high,
        fit: fitCover ? BoxFit.cover : null,
        width: width,
        height: height,
        imageUrl: url,
        placeholder: (context, url) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(
                color: Colors.amber,
              ),
            )
          ],
        ),
        errorWidget: (context, url, error) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error,
                color: AppColors.red3,
                size: 40,
              ),
              SizedBox(height: 4),
              Text(
                "Kiểm tra kết nối mạng!",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.red3,
                ),
              )
            ],
          );
        },
      );
  }
}
