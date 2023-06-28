import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rse/all.dart';

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

class ChartBloc extends Bloc<ChartEvent, ChartState> {
  late Chart chart;
  final AssetBloc assetBloc;

  ChartBloc({ required this.chart, required this.assetBloc}) :super(ChartInitial(chart)) {
    assetBloc.stream.listen((state) {
      if (state is AssetLoaded) {
        updateChart(state.asset, state.asset.sym);
      }
    });
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

  void chartPortfolio(Portfolio p) {
    final newChart = chart.copyWith(
      sym: 'Investing',
      data: p.series,
      startValue: p.series.last.y,
      latestValue: p.series.first.y,
      portfolioStartValue: p.series.last.y,
    );
    chart = newChart;
    add(ChartUpdate(newChart));
  }

  void hoveredLineChart(DataPoint p, double xOffSet) {
    final newChart = chart.copyWith(
      time: p.x,
      xOffSet: xOffSet,
      focusedPoint: p,
    );
    chart = newChart;
    add(HoveredLineChart(newChart));
  }

  void hoveredChart(CandleStick c, double xOffSet) {
    final newChart = chart.copyWith(
      candle: c,
      time: c.time,
      xOffSet: xOffSet,
      focusedPoint: DataPoint(c.time, c.value),
    );

    chart = newChart;
    add(HoveredChart(newChart));
  }

  void updateChart(Asset a, String sym) {
    final point = DataPoint(a.current.last.time, a.current.last.close);
    final newChart = chart.copyWith(
      sym: sym,
      startValue: a.o,
      latestValue: point.y,
      candle: a.current.last,
      candleSeries: a.current,
      assetStartValue: a.current.first.open,
      portfolioStartValue: a.current.last.y,
    );
    chart = newChart;
    add(ChartUpdate(newChart));
  }

  void updateChartPortfolioValues(Portfolio p) {
    final newChart = chart.copyWith(
      sym: 'Investing',
      data: p.series,
      startValue: p.series.last.y,
      latestValue: p.current.totalValue,
      portfolioStartValue: p.series.last.y,
    );
    chart = newChart;
    add(ChartUpdate(newChart));
  }
}
