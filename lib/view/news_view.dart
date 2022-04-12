import 'package:appcent_news_task/constants/constants.dart';
import 'package:appcent_news_task/model/news_model.dart';
import 'package:appcent_news_task/view/detail_view.dart';

import 'package:appcent_news_task/viewmodel/news_view_model.dart';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class NewsView extends StatefulWidget {
  NewsView({Key? key}) : super(key: key);

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  var _textEditingController = TextEditingController();

  bool _isLoading = false;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    //_textEditingController.text = "besiktas";
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
      body: newsPageBody(context),
    );
  }

  Column newsPageBody(BuildContext context) {
    final _newsViewModel = Provider.of<NewsViewModel>(context, listen: false);

    return Column(children: [
      SizedBox(
        height: MediaQuery.of(context).size.height / 15,
      ),
      Text(
        Constants.instance.appTitle,
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
              child: TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: IconButton(
                  onPressed: (() {
                    _newsViewModel.models.clear();
                    setState(() {});
                  }),
                  icon: const Icon(Icons.search)),
              hintText: Constants.instance.searchTextFieldHintText,
              suffixIcon: IconButton(
                onPressed: _textEditingController.clear,
                icon: const Icon(Icons.clear),
              ),
            ),
          ))),
      SizedBox(
        height: MediaQuery.of(context).size.height / 15,
      ),
      Expanded(
        child: FutureBuilder<List<NewsModel>?>(
          future: _newsViewModel.fetchAllData(
              searchingCategory: _textEditingController.text
                  .replaceAll(' ', '')
                  .toLowerCase()),
          builder: (context, snapshot) => ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => Navigator.of(context, rootNavigator: false)
                    .push(MaterialPageRoute(
                  builder: (context) => DetailView(newsIndex: index),
                )),
                child: Card(
                  child: ListTile(
                    focusColor: Colors.red,
                    title: Text(_newsViewModel.models[index].title.toString()),
                    subtitle: Text(
                        _newsViewModel.models[index].description.toString()),
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
      )
    ]);
  }

  void bringMoreUsers() {
    if (_isLoading == false) {
      _isLoading = true;

      // pagination işlemlerini yap
      //final _allUsersViewModel =
      //  Provider.of<AllUsersViewModel>(context, listen: false);

      // _allUsersViewModel.bringMoreUsers();

      _isLoading = false;
    }
  }

  void _listScrollListener() {
    // scroll controlleri sürekli kontrol etmemize gerek yok
    // ya yukarı ya da aşşağı vardıysa kontrol etsek yeterli olur.

    // minScroolExtent listenin en başına geldiğimizde oluşur
    // maxScrollExtent listenin en altına geldiğimizde olusur
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      bringMoreUsers();
    }
  }
}
