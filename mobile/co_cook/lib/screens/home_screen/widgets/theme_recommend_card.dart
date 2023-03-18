import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import 'package:co_cook/styles/colors.dart';
import 'package:co_cook/styles/text_styles.dart';

import 'package:co_cook/screens/list_screen/list_screen.dart';

class ThemeRecommendCard extends StatelessWidget {
  const ThemeRecommendCard({
    super.key,
    required this.data,
  });
  final Map data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        gotoList(context, data['themeName'], data["imgPath"]);
      },
      child: ZoomTapAnimation(
        end: 0.98,
        child: Stack(children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(data["imgPath"]), // 배경 이미지
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(1, 1),
                  blurRadius: 6.0,
                  spreadRadius: 0.0,
                )
              ],
            ),
            margin: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            width: 120,
            height: 120,
          ),
          Positioned(
              top: 28,
              left: 24,
              right: 24,
              child: Text(data["themeName"],
                  style: const CustomTextStyles().subtitle1.copyWith(
                      color: CustomColors.monotoneLight,
                      shadows: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(1, 1),
                          blurRadius: 6.0,
                          spreadRadius: 0.0,
                        )
                      ])))
        ]),
      ),
    );
  }
}

void gotoList(BuildContext context, String listName, String imgPath) {
  Route themeScreen = MaterialPageRoute(
      builder: (context) => ListScreen(listName: listName, imgPath: imgPath));
  Navigator.push(context, themeScreen);
}
