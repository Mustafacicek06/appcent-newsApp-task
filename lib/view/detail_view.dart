import 'package:appcent_news_task/constants/constants.dart';
import 'package:appcent_news_task/constants/style_constants.dart';
import 'package:appcent_news_task/model/news_model.dart';

import 'package:appcent_news_task/view/web_view.dart';
import 'package:appcent_news_task/viewmodel/news_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class DetailView extends StatefulWidget {
  DetailView({Key? key, required this.newsIndex}) : super(key: key);
  final int newsIndex;

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  final GlobalKey _widgetKey = GlobalKey();

  List<NewsModel>? _favoriteNewsList = [];

  @override
  Widget build(BuildContext context) {
    final _newsViewModel = Provider.of<NewsViewModel>(context);

    int? _publishedYear =
        _newsViewModel.models[widget.newsIndex].publishedAt?.year;
    int? _publishedMonth =
        _newsViewModel.models[widget.newsIndex].publishedAt?.month;
    int? _publishedDay =
        _newsViewModel.models[widget.newsIndex].publishedAt?.day;

    return Scaffold(
      appBar: scaffoldAppBar(_newsViewModel),
      body: scaffoldBody(_newsViewModel, _publishedYear, _publishedMonth,
          _publishedDay, context),
    );
  }

  AppBar scaffoldAppBar(NewsViewModel _newsViewModel) {
    return AppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: scaffoldAppBarItems(_newsViewModel),
        )
      ],
    );
  }

  Row scaffoldAppBarItems(NewsViewModel _newsViewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
            onTap: () =>
                Share.share("${_newsViewModel.models[widget.newsIndex].url}"),
            child: const Icon(Icons.ios_share)),
        const SizedBox(
          width: 15,
        ),
        InkWell(
            onTap: () {
              setState(() {
                _favoriteNewsList!.add(_newsViewModel.models[widget.newsIndex]);
                NewsModel.setFavoriteNews(_favoriteNewsList!);
              });
            },
            child: Icon(Icons.favorite))
      ],
    );
  }

  Padding scaffoldBody(NewsViewModel _newsViewModel, int? _publishedYear,
      int? _publishedMonth, int? _publishedDay, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          scaffoldBodyNewsImage(_newsViewModel),
          const SizedBox(
            height: 10,
          ),
          scaffoldBodyNewsTitleText(_newsViewModel),
          scaffoldBodyIcons(
              _newsViewModel, _publishedYear, _publishedMonth, _publishedDay),
          scaffoldBodyNewsContentText(_newsViewModel),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: false)
                    .push(MaterialPageRoute(
                  builder: (context) =>
                      WebViewPage(selectedIndex: widget.newsIndex),
                ));
              },
              child: Text('GO TO '))
        ],
      ),
    );
  }

  Text scaffoldBodyNewsTitleText(NewsViewModel _newsViewModel) {
    return Text(
      _newsViewModel.models[widget.newsIndex].title.toString(),
      style: StyleConstants.instance.newsTitleStyle,
    );
  }

  Flexible scaffoldBodyNewsImage(NewsViewModel _newsViewModel) {
    return Flexible(
      child: ClipRRect(
          child: Image.network(
        _newsViewModel.models[widget.newsIndex].urlToImage.toString(),
        errorBuilder: (context, error, stackTrace) {
          return Text(Constants.instance.imageNotFound);
        },
      )),
    );
  }

  Row scaffoldBodyIcons(NewsViewModel _newsViewModel, int? _publishedYear,
      int? _publishedMonth, int? _publishedDay) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: ListTile(
            leading: const Icon(Icons.access_alarm),
            trailing: Text(
              _newsViewModel.models[widget.newsIndex].author.toString(),
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        Expanded(
            child: ListTile(
          leading: const Icon(Icons.date_range_outlined),
          trailing:
              Text("${_publishedYear}-${_publishedMonth}-${_publishedDay}"),
        ))
      ],
    );
  }

  SingleChildScrollView scaffoldBodyNewsContentText(
      NewsViewModel _newsViewModel) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Text(_newsViewModel.models[widget.newsIndex].content.toString()),
    );
  }
}
