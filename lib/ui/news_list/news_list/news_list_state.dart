part of 'news_list_bloc.dart';

class NewsListState {
  List<FirebaseNews> news;
  List<FirebaseNews> topNews;
  bool newsIsEmpty;
  bool isLoading;
  FirebaseNews oneNews;

  NewsListState(
      {this.news,
      this.topNews,
      this.newsIsEmpty = true,
      this.isLoading = true,
      this.oneNews});
}

class OpenDetailState extends NewsListState {}
