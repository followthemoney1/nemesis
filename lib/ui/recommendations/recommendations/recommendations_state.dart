part of 'recommendations_bloc.dart';

class RecommendationsState {
  final List<FirebaseNews> news;
  final bool isLoading;
  final bool newsIsEmpty;
  const RecommendationsState(
      {this.news, this.isLoading = true, this.newsIsEmpty = false});
}
