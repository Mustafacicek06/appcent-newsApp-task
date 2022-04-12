import 'package:appcent_news_task/constants/constants.dart';
import 'package:appcent_news_task/model/news_model.dart';
import 'package:appcent_news_task/view/detail_view.dart';
import 'package:appcent_news_task/viewmodel/news_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesView extends StatelessWidget {
  FavoritesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _newsViewModel = Provider.of<NewsViewModel>(context);

    return Scaffold(
      body: ListView.builder(
        itemCount: NewsModel.favoriteNews?.length ?? 0,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => Navigator.of(context, rootNavigator: false)
                .push(MaterialPageRoute(
              builder: (context) => DetailView(newsIndex: index),
            )),
            child: Card(
              child: ListTile(
                focusColor: Colors.red,
                title: Text(NewsModel.favoriteNews![index].title.toString()),
                subtitle:
                    Text(NewsModel.favoriteNews![index].description.toString()),
                trailing: ClipRRect(
                    child: Image.network(
                  NewsModel.favoriteNews![index].urlToImage.toString(),
                  errorBuilder: (context, error, stackTrace) {
                    return Text(Constants.instance.imageNotFound);
                  },
                )),
              ),
            ),
          );
        },
      ),
    );
  }
}
