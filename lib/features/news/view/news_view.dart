import 'package:appcent_news_task/core/constants/constants.dart';
import 'package:appcent_news_task/core/constants/style_constants.dart';
import 'package:appcent_news_task/features/news/model/news_model.dart';
import 'package:appcent_news_task/features/news/view/detail_view.dart';
import 'package:appcent_news_task/features/news/viewmodel/news_view_model.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class NewsView extends StatefulWidget {
  const NewsView({Key? key}) : super(key: key);

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  var _textEditingController = TextEditingController();

  // flag control variable
  bool _isLoading = false;

  // Any more news to bring?

  // most recently brought news

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // sürekli kontrol etmemize gerek yok yani sadece
    // köşelere vardığında kontrol ederiz

    _scrollController.addListener(() {
      if (Constants.instance.pageCounter <= 5) {
        _listScrollListener(_textEditingController.text);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: newsViewScaffoldBody(context),
    );
  }

  Column newsViewScaffoldBody(BuildContext context) {
    final _newsViewModel = Provider.of<NewsViewModel>(context, listen: false);

    return Column(children: [
      SizedBox(
        height: MediaQuery.of(context).size.height / 15,
      ),
      appTitleTextWidget(),
      appTextField(_newsViewModel),
      SizedBox(
        height: MediaQuery.of(context).size.height / 15 - 30,
      ),
      bringsNewsFutureBuilder(_newsViewModel)
    ]);
  }

  Text appTitleTextWidget() {
    return Text(
      Constants.instance.appTitle,
      style: StyleConstants.instance.appTitleTextStyle,
    );
  }

  Padding appTextField(NewsViewModel _newsViewModel) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
            child: TextField(
          controller: _textEditingController,
          decoration: textFieldDecoration(_newsViewModel),
        )));
  }

  InputDecoration textFieldDecoration(NewsViewModel _newsViewModel) {
    return InputDecoration(
      border: InputBorder.none,
      prefixIcon: IconButton(
          onPressed: (() {
            _newsViewModel.models.clear();
            Constants.instance.pageCounter = 1;
            setState(() {});
          }),
          icon: const Icon(Icons.search)),
      hintText: Constants.instance.searchTextFieldHintText,
      suffixIcon: IconButton(
        onPressed: _textEditingController.clear,
        icon: const Icon(Icons.clear),
      ),
    );
  }

  Expanded bringsNewsFutureBuilder(NewsViewModel _newsViewModel) {
    return Expanded(
      child: FutureBuilder<List<NewsModel>?>(
        future: _newsViewModel.fetchAllData(
            searchingCategory:
                _textEditingController.text.replaceAll(' ', '').toLowerCase()),
        builder: (context, snapshot) => ListView.builder(
          controller: _scrollController,
          itemCount: snapshot.data?.length ?? 0,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => Navigator.of(context, rootNavigator: true)
                  .push(MaterialPageRoute(
                builder: (context) => DetailView(newsIndex: index),
              )),
              child: Card(
                child: ListTile(
                  focusColor: Colors.red,
                  title: Text(_newsViewModel.models[index].title.toString()),
                  subtitle:
                      Text(_newsViewModel.models[index].description.toString()),
                  trailing: ClipRRect(
                      child: Image.network(
                    _newsViewModel.models[index].urlToImage.toString(),
                    errorBuilder: (context, error, stackTrace) {
                      return Text(Constants.instance.imageNotFound);
                    },
                  )),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void bringMoreNews(String? searchingCategory) async {
    if (_isLoading == false) {
      _isLoading = true;

      setState(() {});
      // pagination işlemlerini yap
      final _newsViewModel = Provider.of<NewsViewModel>(context, listen: false);

      await _newsViewModel.fetchAllData(searchingCategory: searchingCategory);

      // _allUsersViewModel.bringMoreUsers();

      _isLoading = false;
    }
  }

  void _listScrollListener(String? searchingCategory) {
    // scroll controlleri sürekli kontrol etmemize gerek yok
    // ya yukarı ya da aşşağı vardıysa kontrol etsek yeterli olur.

    // minScroolExtent listenin en başına geldiğimizde oluşur
    // maxScrollExtent listenin en altına geldiğimizde olusur
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      bringMoreNews(searchingCategory);
    }
  }
}
