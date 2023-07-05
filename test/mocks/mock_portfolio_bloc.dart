import 'package:bloc/bloc.dart';

import 'package:rse/all.dart';

class MockBlocPortfolio<Event, State> extends Bloc<Event, State> {
  MockBlocPortfolio(PortfolioInitial portfolioInitial)
      : super(portfolioInitial as State);

  @override
  Stream<State> mapEventToState(Event event) async* {
    yield* Stream.empty();
  }
}

class MockPortfolioBloc
    extends MockBlocPortfolio<PortfolioEvent, PortfolioState>
    implements PortfolioBloc {
  late Portfolio portfolio = Portfolio.defaultPortfolio();

  MockPortfolioBloc() : super(PortfolioInitial(Portfolio.defaultPortfolio()));

  @override
  Future<void> fetchPortfolio(int i) async {}

  @override
  List<DataPoint> getDataPoints(List<CandleStick> list) {
    // TODO: implement getDataPoints
    throw UnimplementedError();
  }

  @override
  // TODO: implement portfolioService
  PortfolioService get portfolioService => throw UnimplementedError();

  @override
  void setPeriod(String p) {
    // TODO: implement setPeriod
  }
}