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

class ChartError extends ChartState {
  final String errorMessage;

  ChartError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class HoverUpdated extends ChartState {
  final Chart chart;

  HoverUpdated(this.chart);

  @override
  List<Object?> get props => [chart];
}

class ChartUpdated extends ChartState {
  final Chart chart;

  ChartUpdated(this.chart);

  @override
  List<Object?> get props => [chart];
}

class ChartCubit extends Cubit<ChartState> {
  double xOffSet = 0;
  Chart chart = Chart.defaultChart();
  ChartCubit() : super(ChartInitial());

  Future<void> setHoveredCandle(c, x) async {
    try {
      chart.xOffSet = x;
      chart.hoveredCandle = c;
      emit(ChartUpdated(chart));
      emit(HoverUpdated(chart));
    } catch (e) {
      emit(ChartError(e.toString()));
    }
  }
}