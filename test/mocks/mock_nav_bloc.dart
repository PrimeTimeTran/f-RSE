import 'package:bloc/bloc.dart';

import 'package:rse/all.dart';

class MocBlocNav<Event, State> extends Bloc<Event, State> {
  MocBlocNav() : super(NavChangeSuccess('0-0', [0, 0, 0, 0]) as State);

  @override
  Stream<State> mapEventToState(Event event) async* {
    yield* Stream.empty();
  }
}

class MockNavBloc extends MocBlocNav<NavEvent, NavState> implements NavBloc {
  MockNavBloc();

  @override
  List<int> get tabStates => throw UnimplementedError();
}