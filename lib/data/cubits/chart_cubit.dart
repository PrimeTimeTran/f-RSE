import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:rse/data/all.dart';

abstract class ChartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchChart extends ChartEvent {
  final String id;

  FetchChart(this.id);

  @override
  List<Object?> get props => [id];
}

abstract class ChartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChartInitial extends ChartState {}

class ChartLoading extends ChartState {}

class ChartLoaded extends ChartState {
  final CandleStick candle;

  ChartLoaded(this.candle);

  @override
  List<Object?> get props => [candle];
}

class ChartUpdated extends ChartState {
  final Chart chart;

  ChartUpdated(this.chart);

  @override
  List<Object?> get props => [chart];
}

class ChartError extends ChartState {
  final String errorMessage;

  ChartError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class ChartCubit extends Cubit<ChartState> {
  double xOffSet = 0;
  Chart chart = Chart.defaultChart();
  CandleStick candle = CandleStick.defaultCandle();

  ChartCubit() : super(ChartInitial());

  Future<void> initializeChartCandle(CandleStick c) async {
    try {
      emit(ChartLoaded(candle));
    } catch (e) {
      emit(ChartError(e.toString()));
    }
  }

  Future<void> setHoveredCandle(CandleStick c, x) async {
    try {
      candle = c;
      chart.xOffSet = x;
      chart.hoveredCandle = c;
      emit(ChartLoaded(c));
      emit(ChartUpdated(chart));
    } catch (e) {
      emit(ChartError(e.toString()));
    }
  }
}