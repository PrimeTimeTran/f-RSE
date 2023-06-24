import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/data/all.dart';

abstract class PortfolioEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadedPortfolio extends PortfolioEvent {
  final Portfolio portfolio;

  LoadedPortfolio(this.portfolio);

  @override
  List<Object?> get props => [portfolio];
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

class PortfolioCubit extends Bloc<PortfolioEvent, PortfolioState> {
  late Portfolio portfolio;
  final PortfolioService portfolioService = PortfolioService();

  PortfolioCubit({ required this.portfolio }) : super(PortfolioInitial(portfolio)) {
    on<LoadedPortfolio>((e, emit) async {
      emit(PortfolioLoaded(e.portfolio));
    });
  }

  Future<void> fetchPortfolio(String id) async {
    emit(PortfolioLoading());
    try {
      final Portfolio p = await portfolioService.fetchPortfolio(id);

      portfolio = p;
      add(LoadedPortfolio(p));
    } catch (e) {
      emit(PortfolioError('fetching portfolio $e'));
    }
  }

  List<DataPoint> getDataPoints(List<CandleStick> list) {
    return list
      .map((time) => DataPoint(time.time, 0))
      .toList();
  }
}
