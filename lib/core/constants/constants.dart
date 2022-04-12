class Constants {
  static Constants instance = Constants._init();
  Constants._init();

  final String baseUrl = "https://newsapi.org/v2/everything?q=";
  final String myNewsApiKeyValue = "90f78b5e459f4557a6d285161db89387";
  String searchingCategory = "";
  String imageNotFound = "Image Not Found";
  String appTitle = "Appcent NewsApp";
  String searchTextFieldHintText = 'Type a Text';
  int pageCounter = 1;
  String webViewTitle = 'News Source';
}
