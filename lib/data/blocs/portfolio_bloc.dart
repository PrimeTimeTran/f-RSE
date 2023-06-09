import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/data/models/all.dart';

import 'package:rse/services/portfolio_service.dart';

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

class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  final PortfolioService portfolioService = PortfolioService();
  List<DataPoint> dataPoints = [];

  PortfolioBloc() : super(PortfolioInitial()) {
    on<FetchPortfolio>(fetchPortfolio);
  }

  void fetchPortfolio(FetchPortfolio e, Emitter<PortfolioState> emit) async {
    emit(PortfolioLoading());

    try {
      final p = await portfolioService.fetchPortfolio(e.id);
      dataPoints = convertToDataPoints(p.series);
      emit(PortfolioLoaded(p));
    } catch (e) {
      emit(PortfolioError('Error fetching portfolio'));
    }
  }

  List<DataPoint> convertToDataPoints(List<CandleStick> list) {
    return list
        .map((time) => DataPoint(time.date ?? '', time.value ?? 0))
        .toList();
  }

  List<DataPoint> getDataPoints() {
    return dataPoints;
  }
}
