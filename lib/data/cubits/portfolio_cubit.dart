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

abstract class PortfolioState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PortfolioInitial extends PortfolioState {}

class PortfolioLoading extends PortfolioState {}

class PortfolioLoaded extends PortfolioState {
  final Portfolio portfolio;

  PortfolioLoaded(this.portfolio);

  @override
  List<Object?> get props => [portfolio];
}

class PortfolioError extends PortfolioState {
  final String errorMessage;

  PortfolioError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class PortfolioCubit extends Cubit<PortfolioState> {
  late double open;
  List<DataPoint> dataPoints = [];
  CandleStick candle = CandleStick.defaultCandle();
  late Portfolio portfolio = Portfolio.defaultPortfolio();
  final PortfolioService portfolioService = PortfolioService();
  PortfolioCubit() : super(PortfolioInitial());

  Future<void> fetchPortfolio(String id) async {
    emit(PortfolioLoading());

    try {
      final p = await portfolioService.fetchPortfolio(id);
      portfolio = p;
      dataPoints = p.series;
      open = dataPoints.last.y;
      emit(PortfolioLoaded(p));
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
