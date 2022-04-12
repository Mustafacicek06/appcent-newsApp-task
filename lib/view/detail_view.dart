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
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                    onTap: () => Share.share(
                        "${_newsViewModel.models[widget.newsIndex].url}"),
                    child: const Icon(Icons.ios_share)),
                const SizedBox(
                  width: 15,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
                        _favoriteNewsList!
                            .add(_newsViewModel.models[widget.newsIndex]);
                        NewsModel.setFavoriteNews(_favoriteNewsList!);
                      });
                    },
                    child: Icon(Icons.favorite))
              ],
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Flexible(
              child: ClipRRect(
                  child: Image.network(
                _newsViewModel.models[widget.newsIndex].urlToImage.toString(),
                errorBuilder: (context, error, stackTrace) {
                  return Text(Constants.instance.imageNotFound);
                },
              )),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              _newsViewModel.models[widget.newsIndex].title.toString(),
              style: StyleConstants.instance.newsTitleStyle,
            ),
            Row(
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
                  trailing: Text(
                      "${_publishedYear}-${_publishedMonth}-${_publishedDay}"),
                ))
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Text(
                  _newsViewModel.models[widget.newsIndex].content.toString()),
            ),
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
      ),
    );
  }
}
