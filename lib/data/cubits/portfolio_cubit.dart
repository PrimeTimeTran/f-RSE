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

class CandleLoaded extends PortfolioState {
  final CandleStick candle;

  CandleLoaded(this.candle);

  @override
  List<Object?> get props => [candle];
}

class PortfolioError extends PortfolioState {
  final String errorMessage;

  PortfolioError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class PortfolioCubit extends Cubit<PortfolioState> {
  List<DataPoint> dataPoints = [];
  final PortfolioService portfolioService = PortfolioService();
  CandleStick candle = CandleStick(time: DateTime.now().toString(), open: 0, high: 0, low: 0, close: 0, value: 0);

  PortfolioCubit() : super(PortfolioInitial());

  Future<void> fetchPortfolio(String id) async {
    emit(PortfolioLoading());

    try {
      final p = await portfolioService.fetchPortfolio(id);
      dataPoints = p.series;

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
