import 'dart:io';
import 'package:appcent_news_task/core/constants/constants.dart';
import 'package:appcent_news_task/features/news/model/news_model.dart';
import 'package:appcent_news_task/features/news/services/network_manager.dart';

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
      if (Constants.instance.pageCounter <= 5) {
        if (response.statusCode == HttpStatus.ok) {
          Constants.instance.pageCounter++;
          (response.data["articles"]).map((e) {});

          for (var element in (response.data["articles"] as List)) {
            models.add(NewsModel.fromJson(element));
            // models.forEach((element) {});
          }

          return models;
        } else {
          return null;
        }
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
