import 'package:rse/data/all.dart';

class LocalStorageState {
  final Portfolio portfolio;
  final List<NewsArticle> articles;

  LocalStorageState({
    required this.portfolio,
    required this.articles,
  });
}
