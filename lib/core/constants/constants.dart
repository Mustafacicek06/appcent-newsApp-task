class Constants {
  static Constants instance = Constants._init();
  Constants._init();

  final String baseUrl = "https://newsapi.org/v2/everything?q=";
  final String myNewsApiKeyValue = "a33cb5bbf203425789b83a9008eee057";
  String searchingCategory = "";
  String imageNotFound = "Image Not Found";
  String appTitle = "Appcent NewsApp";
  String searchTextFieldHintText = 'Type a Text';
  int pageCounter = 1;
  String webViewTitle = 'News Source';
  int? webViewSelectedIndex;
}
