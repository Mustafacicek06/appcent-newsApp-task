class Constants {
  static Constants instance = Constants._init();
  Constants._init();

  final String baseUrl = "https://newsapi.org/v2/everything?q=";
  final String myNewsApiKeyValue = "f7621e0445354e7391d23f31b460a130";
  String searchingCategory = "";
  String imageNotFound = "Image Not Found";
  String appTitle = "Appcent NewsApp";
  String searchTextFieldHintText = 'Type a Text';
  int pageCounter = 1;
  String webViewTitle = 'News Source';
  int? webViewSelectedIndex;
}
