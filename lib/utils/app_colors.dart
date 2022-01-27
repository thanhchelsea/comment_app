import 'package:flutter/material.dart';

class AppColors {
  //blue
  static const Color blue = Color.fromRGBO(29, 161, 242, 1);
  static const Color blue0 = Color.fromRGBO(44, 225, 193, 1);
  static const Color blue4 = Color.fromRGBO(45, 194, 124, 1);
  static const Color blue1 = Color.fromRGBO(35, 202, 239, 1);
  static const Color blue2 = Color.fromRGBO(131, 169, 191, 1);
  static const Color blue3 = Color.fromRGBO(238, 242, 252, 1);
  static const Color blue5 = Color.fromRGBO(0, 131, 205, 1);
  static const Color blue6 = Color.fromRGBO(203, 229, 250, 1);
  static const Color blue7 = Color.fromRGBO(86, 188, 255, 1);
  static const Color blue8 = Color.fromRGBO(116, 236, 255, 1);
  static const Color blue9 = Color.fromRGBO(0, 175, 186, 1);
  //teal
  static const Color teal = Color.fromRGBO(8, 155, 129, 1);
  static const Color teal1= Color.fromRGBO(33, 77, 69, 1);

  //red
  static const Color red = Color.fromRGBO(191, 29, 45, 1);
  static const Color red0 = Color.fromRGBO(248, 105, 182, 1);
  static const Color red1 = Color.fromRGBO(255, 148, 140, 1);
  static const Color red2 = Color.fromRGBO(245, 64, 130, 1);
  static const Color red3 = Color.fromRGBO(255, 84, 84, 1);
  static const Color red4 = Color.fromRGBO(255, 125, 107, 1);
  static const Color red5 = Color.fromRGBO(255, 192, 184, 1);

  //pink
  static const Color pink = Color.fromRGBO(255, 99, 192, 1);
  //green
  static const Color green = Color.fromRGBO(186, 215, 97, 1);
  static const Color green0 = Color.fromRGBO(128, 183, 38, 1);
  static const Color green1 = Color.fromRGBO(169, 221, 84, 1);
  static const Color green3 = Color.fromRGBO(193, 218, 58, 1);
  static const Color green2 = Color.fromRGBO(154, 178, 175, 1);
  static const Color green4 = Color.fromRGBO(172, 194, 94, 1);
  static const Color green5 = Color.fromRGBO(130, 188, 36, 1);
  static const Color green6 = Color.fromRGBO(0, 197, 149, 1);
  static const Color green7 = Color.fromRGBO(67, 207, 142, 1);
  static const Color green8 = Color.fromRGBO(173, 240, 209, 1);

  //black
  static const Color black = Color.fromRGBO(135, 135, 135, 1);
  static const Color black0 = Color.fromRGBO(41, 49, 58, 1);
  static const Color black1 = Color.fromRGBO(238, 242, 252, 1);
  static const Color black2 = Color.fromRGBO(219, 228, 238, 1);
  static const Color black3 = Color.fromRGBO(132, 155, 182, 1);
  static const Color black4 = Color.fromRGBO(182, 207, 221, 1);

  //white
  static const Color white0 = Color.fromRGBO(247, 249, 252, 1);
  static const Color white1 = Color.fromRGBO(255, 255, 255, 1);
  static const Color white2 = Color.fromRGBO(244, 247, 253, 1);

//yellow
  static const Color yellow0 = Color.fromRGBO(255, 201, 163, 1);
  static const Color yellow1 = Color.fromRGBO(255, 212, 82, 1);
  static const Color yellow2 = Color.fromRGBO(255, 201, 63, 1);
  static const Color yellow3 = Color.fromRGBO(255, 228, 159, 1);
  static const Color yellow4 = Color.fromRGBO(255, 189, 62, 1);


  static LinearGradient gradientColor(List<Color> colors,
      {bool vertical = true,List<double>? stops}) {
    return LinearGradient(
      begin: vertical ? Alignment.topLeft : Alignment.centerLeft,
      end: vertical ? Alignment.bottomRight : Alignment.centerRight,
      // Add one stop for each color. Stops should increase from 0 to 1
      stops: stops,
      colors: colors,
    );
  }

  static RadialGradient radialColor(List<Color> colors,
      {bool vertical = true,List<double>? stops}) {
    return RadialGradient(
       center: Alignment(0.5, 0.5), // near the top right
       radius: 0.9,
      colors: colors,
      // stops: <double>[0.0, 0.1],
    );
  }

 static List<Color> listColorsMatchGame = [
    AppColors.white1,
    AppColors.yellow4,
    AppColors.green7,
    AppColors.blue7,
   AppColors.red4,
   AppColors.black3,
  ];
}
