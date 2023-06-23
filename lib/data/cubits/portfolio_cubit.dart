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
  final double startValue;
  final Portfolio portfolio;

  LoadedPortfolio(this.portfolio, this.value, this.startValue);

  @override
  List<Object?> get props => [portfolio, value, startValue];
}

abstract class PortfolioState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PortfolioInitial extends PortfolioState {}

class PortfolioLoading extends PortfolioState {}

class PortfolioLoaded extends PortfolioState {
  final double value;
  final double startValue;
  final Portfolio portfolio;

  PortfolioLoaded(this.portfolio, this.value, this.startValue);

  @override
  List<Object?> get props => [portfolio, value, startValue];
}

class PortfolioError extends PortfolioState {
  final String errorMessage;

  PortfolioError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class PortfolioCubit extends Bloc<PortfolioEvent, PortfolioState> {
  late double startValue = 100;
  late double currentValue = 300;
  List<DataPoint> dataPoints = [];
  CandleStick candle = CandleStick.fact();
  final PortfolioService portfolioService = PortfolioService();

  PortfolioCubit() : super(PortfolioInitial()) {
    on<LoadedPortfolio>((e, emit) async {
      emit(PortfolioLoaded(e.portfolio, e.value, e.startValue));
    });
  }

  Future<void> fetchPortfolio(String id) async {
    emit(PortfolioLoading());
    try {
      final p = await portfolioService.fetchPortfolio(id);
      dataPoints = p.series;
      startValue = dataPoints.last.y;
      currentValue = dataPoints.first.y;
      add(LoadedPortfolio(p, p.current.totalValue, startValue));
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
