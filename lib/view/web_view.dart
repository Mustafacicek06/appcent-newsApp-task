import 'package:appcent_news_task/constants/constants.dart';
import 'package:appcent_news_task/viewmodel/news_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatelessWidget {
  WebViewPage({Key? key, required this.selectedIndex}) : super(key: key);

  int selectedIndex;

  @override
  Widget build(BuildContext context) {
    final _newsViewModel = Provider.of<NewsViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.instance.webViewTitle),
        centerTitle: true,
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: _newsViewModel.models[selectedIndex].url,
      ),
    );
  }
}
