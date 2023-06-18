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

class ChartError extends ChartState {
  final String errorMessage;

  ChartError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class ChartCubit extends Cubit<ChartState> {
  List<DataPoint> dataPoints = [];
  CandleStick candle = CandleStick(time: DateTime.now().toString(), open: 0, high: 0, low: 0, close: 0, value: 0);

  ChartCubit() : super(ChartInitial());

  Future<void> initializeChartCandle() async {
    try {
      emit(ChartLoading());
      candle = CandleStick.defaultCandle();
      emit(ChartLoaded(candle));
    } catch (e) {
      emit(ChartError(e.toString()));
    }
  }

  Future<void> setHoveredSeriesItem(CandleStick c) async {
    emit(ChartLoading());
    try {
      candle = c;
      emit(ChartLoaded(c));
    } catch (e) {
      emit(ChartError(e.toString()));
    }
  }
}