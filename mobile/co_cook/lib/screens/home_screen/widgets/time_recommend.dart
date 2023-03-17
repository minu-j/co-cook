import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:dio/dio.dart'; // Response 가져오기 위함.
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:co_cook/styles/colors.dart';
import 'package:co_cook/styles/text_styles.dart';

import 'package:co_cook/widgets/card/grid_card.dart';
import 'package:co_cook/services/recommend_service.dart';

class TimeRecommend extends StatefulWidget {
  const TimeRecommend({super.key, required this.dataList});
  final List<Map> dataList;

  @override
  State<TimeRecommend> createState() => _TimeRecommendState();
}

class _TimeRecommendState extends State<TimeRecommend> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTimeRecommendData("/home/recommend");
  }

  var dataList = [];

  Future<void> getTimeRecommendData(String apiPath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userData = prefs.getString('userData') ?? '';
    // API 요청
    RecommendService _recommendService = RecommendService();
    Response? response = await _recommendService.getTimeRecommend(apiPath);

    // 디코딩
    var decodeRes = await jsonDecode(response.toString());
    if (decodeRes != null) {
      setState(() {
        dataList = decodeRes["data"]["recipes"];
      });
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(24.0, 32.0, 24.0, 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("오늘 저녁,",
                  style: const CustomTextStyles().title2.copyWith(
                        color: CustomColors.redPrimary,
                      )),
              Container(
                margin: const EdgeInsets.only(top: 8),
                child: Text("이런 요리 어때요?",
                    style: const CustomTextStyles().subtitle1.copyWith(
                          color: CustomColors.monotoneBlack,
                        )),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.82,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return GridCard(
                data: dataList[index],
              );
            },
            itemCount: dataList.length,
            viewportFraction: 0.65,
            scale: 0.7,
            autoplay: true,
            autoplayDelay: 7000,
            duration: 1000,
          ),
        )
      ]),
    );
  }
}