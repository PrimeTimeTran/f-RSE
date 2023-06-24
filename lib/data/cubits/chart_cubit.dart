import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'package:rse/data/all.dart';

@immutable
abstract class ChartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChartInitialized extends ChartEvent {
  final Chart chart;
  ChartInitialized(this.chart);

  @override
  List<Object?> get props => [chart];
}

class ChartUpdate extends ChartEvent {
  final Chart chart;
  ChartUpdate(this.chart);

  @override
  List<Object?> get props => [chart];
}

class HoveredChart extends ChartEvent {
  final Chart chart;
  HoveredChart(this.chart);

  @override
  List<Object?> get props => [chart];
}

class HoveredLineChart extends ChartEvent {
  final Chart chart;
  HoveredLineChart(this.chart);

  @override
  List<Object?> get props => [chart];
}

abstract class ChartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChartInitial extends ChartState {
  final Chart chart;
  ChartInitial(this.chart);

  @override
  List<Object?> get props => [chart];
}

class UpdatedChart extends ChartState {
  final Chart chart;
  UpdatedChart(this.chart);

  @override
  List<Object?> get props => [chart];
}

class HoveringChart extends ChartState {
  final Chart chart;
  HoveringChart(this.chart);

  @override
  List<Object?> get props => [chart];
}

class HoveringLineChart extends ChartState {
  final Chart chart;
  HoveringLineChart(this.chart);

  @override
  List<Object?> get props => [chart];
}

class ChartCubit extends Bloc<ChartEvent, ChartState> {
  late Chart chart;

  ChartCubit({ required this.chart}) : super(ChartInitial(chart)) {
    on<HoveredChart>((e, emit) {
      emit(HoveringChart(e.chart));
    });
    on<HoveredLineChart>((e, emit) {
      emit(HoveringLineChart(e.chart));
    });
    on<ChartUpdate>((e, emit) {
      emit(UpdatedChart(e.chart));
    });
  }

  void chartPortfolio(Portfolio portfolio) {
    final newChart = chart.copyWith(
      data: portfolio.series,
      startValue: portfolio.series.last.y,
      latestValue: portfolio.series.first.y,
      portfolioStartValue: portfolio.series.last.y,
    );
    chart = newChart;
    add(ChartUpdate(newChart));
  }

  hoveredLineChart(DataPoint p, double xOffSet) {
    final newChart = chart.copyWith(
      time: p.x,
      xOffSet: xOffSet,
      focusedPoint: p,
    );
    chart = newChart;
    add(HoveredLineChart(newChart));
  }

  void hoveredChart(DataPoint? p, CandleStick? c, double xOffSet) {
    var isPoint = p != null;
    var isCandle = c != null;

    final newChart = chart.copyWith(
      xOffSet: xOffSet,
      time: isPoint ? p.x : c!.time,
    );

    newChart.candle = isCandle ? c : newChart.candle;
    newChart.focusedPoint = isPoint ? p : DataPoint(c!.time, c!.value);

    chart = newChart;
    add(HoveredChart(newChart));
  }

  void assetLoaded(AssetCubit cubit) {
    var newChart = chart.copyWith(
      sym: cubit.asset.sym,
      startValue: cubit.asset.o,
      latestValue: cubit.asset.value,
      candle: cubit.asset.current.last,
      candleSeries: cubit.asset.current,
    );
    // print(cubit.asset.o);
    chart = newChart;
    add(ChartUpdate(newChart));
  }
}
