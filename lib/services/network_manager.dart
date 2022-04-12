import 'package:appcent_news_task/constants/constants.dart';
import 'package:dio/dio.dart';

class NetworkManager {
  static NetworkManager? _instance;
  static NetworkManager get instance {
    if (_instance != null) return _instance!;
    _instance = NetworkManager._init();

    return _instance!;
  }

  late final Dio dio;
  // query parametresi yap
  // daha sonra da page parametresi yap
  NetworkManager._init() {
    dio = Dio(BaseOptions(baseUrl: Constants.instance.baseUrl));
  }
}
