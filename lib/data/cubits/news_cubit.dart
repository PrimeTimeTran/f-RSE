import 'package:bloc/bloc.dart';
import 'package:rse/data/services/all.dart';
import 'package:rse/data/models/all.dart';
import 'package:rse/data/services/news_service.dart';

class NewsCubit extends Cubit<List<Article>> {
  final NewsService _newsService = NewsService();

  NewsCubit() : super([]);

  Future<void> fetchArticles() async {
    try {
      final articles = await _newsService.fetchArticles();
      emit(articles);
    } catch (error) {
      print('Error fetching articles: $error');
      // Handle error case
      // ...
    }
  }
}
