import 'package:rse/data/all.dart';

class LocalStorageState {
  final Portfolio portfolio;
  final List<Article> articles;

  LocalStorageState({
    required this.portfolio,
    required this.articles,
  });
}
