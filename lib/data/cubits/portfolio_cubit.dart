import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/data/all.dart';

abstract class PortfolioEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchPortfolio extends PortfolioEvent {
  final String id;

  FetchPortfolio(this.id);

  @override
  List<Object?> get props => [id];
}

class LoadedPortfolio extends PortfolioEvent {
  final double value;
  final Portfolio portfolio;

  LoadedPortfolio(this.portfolio, this.value);

  @override
  List<Object?> get props => [portfolio, value];
}

abstract class PortfolioState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PortfolioInitial extends PortfolioState {}

class PortfolioLoading extends PortfolioState {}

class PortfolioLoaded extends PortfolioState {
  final double value;
  final Portfolio portfolio;

  PortfolioLoaded(this.portfolio, this.value);

  @override
  List<Object?> get props => [portfolio, value];
}

class PortfolioError extends PortfolioState {
  final String errorMessage;

  PortfolioError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class PortfolioCubit extends Bloc<PortfolioEvent, PortfolioState> {
  List<DataPoint> dataPoints = [];
  CandleStick candle = CandleStick.fact();
  final PortfolioService portfolioService = PortfolioService();

  PortfolioCubit() : super(PortfolioInitial()) {
    on<LoadedPortfolio>((e, emit) async {
      emit(PortfolioLoaded(e.portfolio, e.value));
    });
  }

  Future<void> fetchPortfolio(String id) async {
    emit(PortfolioLoading());
    try {
      final p = await portfolioService.fetchPortfolio(id);
      dataPoints = p.series;
      add(LoadedPortfolio(p, p.current.totalValue));
    } catch (e) {
      emit(PortfolioError('fetching portfolio'));
    }
  }

  List<DataPoint> getDataPoints(List<CandleStick> list) {
    return list
        .map((time) => DataPoint(time.time, 0))
        .toList();
  }
}
