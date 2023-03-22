import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:co_cook/styles/colors.dart';
import 'package:co_cook/styles/text_styles.dart';
import 'package:co_cook/widgets/card/list_card.dart';

import 'package:co_cook/services/list_service.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List dataList = [];

  @override
  void initState() {
    super.initState();
    getDetailInfo();
  }

  Future<void> getDetailInfo() async {
    // API 요청
    ListService searchService = ListService();
    Response? response = await searchService.getFavoriteList();
    if (response?.statusCode == 200) {
      Map? decodeRes = await jsonDecode(response.toString());
      print(decodeRes);
      if (decodeRes != null) {
        setState(() {
          dataList = decodeRes["data"]['recipeListResDto'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.monotoneLight,
        elevation: 0.5,
        title: const SizedBox.shrink(), // Remove the original title
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: CustomColors.monotoneBlack),
                onPressed: () => Navigator.of(context).pop(),
              ),
              Text(
                '내가 찜한 레시피',
                style: const CustomTextStyles()
                    .subtitle1
                    .copyWith(color: CustomColors.monotoneBlack),
              ),
              SizedBox(width: 48), // Add space to balance the back button width
            ],
          ),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: dataList.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: dataList.length,
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: ListCard(data: dataList[index]),
                    );
                  })
              : const Center(
                  child: CircularProgressIndicator(
                      color: CustomColors.redPrimary)),
        ),
      ),
    );
  }
}
