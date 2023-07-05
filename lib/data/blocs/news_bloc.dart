import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import 'package:rse/data/all.dart';

abstract class NewsEvent {}

class FetchArticles extends NewsEvent {}

abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoaded extends NewsState {
  final List<NewsArticle> articles;

  NewsLoaded(this.articles);
}

class NewsError extends NewsState {
  final dynamic error;

  NewsError(this.error);
}

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsService _newsService = NewsService();

  NewsBloc() : super(NewsInitial());

  Future<void> fetchArticles() async {
    try {
      final articles = await _newsService.fetchArticles();
      emit(NewsLoaded(articles));
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching articles: $error');
      }
    }
  }

  @override
  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    if (event is FetchArticles) {
      yield* _mapFetchArticlesToState();
    }
  }

  Stream<NewsState> _mapFetchArticlesToState() async* {
    try {
      final articles = await _newsService.fetchArticles();
      yield NewsLoaded(articles);
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching articles: $error');
      }
      yield NewsError(error);
    }
  }
}
