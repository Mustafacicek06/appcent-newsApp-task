import 'dart:io';

import 'package:appcent_news_task/constants/constants.dart';
import 'package:appcent_news_task/model/news_model.dart';
import 'package:appcent_news_task/services/network_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NewsViewModel with ChangeNotifier {
  final Dio dio = NetworkManager.instance.dio;

  List<NewsModel> models = [];

  NewsViewModel() {
    fetchAllData();
  }

  Future<List<NewsModel>?> fetchAllData({String? searchingCategory}) async {
    searchingCategory?.replaceAll(RegExp(r"\s+"), "");
    Constants.instance.searchingCategory = searchingCategory ?? "besiktas";

    final response = await dio.get(ServicePath.search.rawValue);
    // http dart.io dan gelmeli dikkat et ona

    try {
      if (response.statusCode == HttpStatus.ok) {
        (response.data["articles"]).map((e) {});

        (response.data["articles"] as List).forEach((element) {
          models.add(NewsModel.fromJson(element));
          models.forEach((element) {});
        });

        // models = NewsModel.fromJson();
        return models;
      }
    } on DioError catch (e) {
      debugPrint(e.message);
    }
  }
}

enum ServicePath { search }

extension ServicePathExtension on ServicePath {
  String get rawValue {
    switch (this) {
      case ServicePath.search:
        return '${Constants.instance.searchingCategory}&page=${Constants.instance.pageCounter}&apiKey=${Constants.instance.myNewsApiKeyValue}';
    }
  }
}
