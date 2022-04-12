import 'package:appcent_news_task/features/news/model/news_model.dart';

abstract class DBBase {
  // keyworde göre arama yap
  Future<List<NewsModel>?> fetchAllData({String? searchingCategory});
}
