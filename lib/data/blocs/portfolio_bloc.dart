import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/data/all.dart';

abstract class PortfolioEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PortfolioLoaded extends PortfolioEvent {
  final Portfolio portfolio;

  PortfolioLoaded(this.portfolio);

  @override
  List<Object?> get props => [portfolio];
}

class LoadError extends PortfolioEvent {
  final String errorMessage;

  LoadError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

abstract class PortfolioState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PortfolioInitial extends PortfolioState {
  final Portfolio portfolio;

  PortfolioInitial(this.portfolio);

  @override
  List<Object?> get props => [portfolio];
}

class PortfolioLoading extends PortfolioState {}

class PortfolioLoadedSuccess extends PortfolioState {
  final Portfolio portfolio;

  PortfolioLoadedSuccess(this.portfolio);

  @override
  List<Object?> get props => [portfolio];
}

class PortfolioError extends PortfolioState {
  final String errorMessage;

  PortfolioError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  late Portfolio portfolio;
  final PortfolioService portfolioService = PortfolioService();

  PortfolioBloc({ required this.portfolio }) : super(PortfolioInitial(portfolio)) {
    on<PortfolioLoaded>((e, emit) async {
      emit(PortfolioLoadedSuccess(e.portfolio));
    });
  }

  Future<void> fetchPortfolio(int id) async {
    try {
      final Portfolio p = await portfolioService.fetchPortfolio(id, portfolio.period);
      portfolio = p;
      add(PortfolioLoaded(p));
    } catch (e) {
      add(LoadError('fetching portfolio $e'));
    }
  }

  List<DataPoint> getDataPoints(List<CandleStick> list) {
    return list
        .map((time) => DataPoint(time.time, 0))
        .toList();
  }

  void setPeriod(String p) async {
    try {
      final port = await portfolioService.fetchPortfolio(portfolio.id, p);
      final newPort = portfolio.copyWith(
        period: p,
        series: port.series
      );
      portfolio = newPort;
      add(PortfolioLoaded(newPort));
    } catch (e) {
      add(LoadError('fetching portfolio $e'));
    }
  }
}
