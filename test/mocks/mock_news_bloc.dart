import 'package:bloc/bloc.dart';

import 'package:rse/all.dart';

class MockBlocNews<Event, State> extends Bloc<Event, State> {
  MockBlocNews() : super(NewsLoaded([]) as State);
}

class MockNewsBloc extends MockBlocNews<NewsEvent, NewsState>
    implements NewsBloc {
  MockNewsBloc();

  @override
  Future<void> fetchArticles() async {}
}