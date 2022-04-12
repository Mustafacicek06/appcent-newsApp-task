class Constants {
  static Constants instance = Constants._init();
  Constants._init();

  final String baseUrl = "https://newsapi.org/v2/everything?q=";
  final String myNewsApiKeyValue = "7cc9c3c573cc49de8b35a460ecb66ce2";
  String searchingCategory = "";
  String imageNotFound = "Image Not Found";
  String appTitle = "Appcent NewsApp";
  String searchTextFieldHintText = 'Type a Text';
  int pageCounter = 1;
  String webViewTitle = 'News Source';
}
