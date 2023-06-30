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

class ChartFocused extends ChartEvent {
  final Chart chart;
  ChartFocused(this.chart);

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

class ChartFocus extends ChartState {
  final Chart chart;
  ChartFocus(this.chart);

  @override
  List<Object?> get props => [chart];
}

class UpdatedChart extends ChartState {
  final Chart chart;
  UpdatedChart(this.chart);

  @override
  List<Object?> get props => [chart];
}

class ChartBloc extends Bloc<ChartEvent, ChartState> {
  late Chart chart;
  final AssetBloc assetBloc;
  final PortfolioBloc portfolioBloc;

  ChartBloc({
    required this.chart,
    required this.assetBloc,
    required this.portfolioBloc
  }) : super(ChartInitial(chart)) {
    assetBloc.stream.listen((state) {
      if (state is AssetLoaded) {
        updateChart(state.asset, state.asset.sym);
      }
    });
    portfolioBloc.stream.listen((state) {
      if (state is PortfolioLoaded) {
        updateChartPortfolio(state.portfolio);
      }
    });

    on<ChartFocused>((e, emit) {
      emit(ChartFocus(e.chart));
    });

    on<ChartUpdate>((e, emit) {
      emit(UpdatedChart(e.chart));
    });
  }

  void chartPortfolio(Portfolio p) {
    final newChart = chart.copyWith(
      sym: 'Investing',
      data: p.series,
      startValue: p.series.first.y,
      latestValue: p.series.last.y,
      portfolioStartValue: p.series.first.y,
    );
    chart = newChart;
    add(ChartUpdate(newChart));
  }

  void hoveredLineChart(DataPoint p, double xOffSet) {
    final newChart = chart.copyWith(
      time: p.x,
      xOffSet: xOffSet,
      focusedValue: p.y,
    );
    chart = newChart;
    add(ChartFocused(newChart));
  }

  void hoveredChart(CandleStick c, double xOffSet) {
    final newChart = chart.copyWith(
      candle: c,
      time: c.time,
      xOffSet: xOffSet,
      focusedValue: c.value,
    );

    chart = newChart;
    add(ChartFocused(newChart));
  }

  void updateChart(Asset a, String sym) {
    final point = DataPoint(a.current.last.time, a.current.last.close);
    final newChart = chart.copyWith(
      sym: sym,
      latestValue: point.y,
      candle: a.current.last,
      candleSeries: a.current,
      startValue: a.current.first.open,
      portfolioStartValue: a.current.last.y,
    );
    chart = newChart;
    add(ChartUpdate(newChart));
  }

  void updateChartPortfolio(Portfolio p) {
    final newChart = chart.copyWith(
      sym: 'Investing',
      data: p.series,
      startValue: p.series.first.y,
      latestValue: p.series.last.y,
      portfolioStartValue: p.series.first.y,
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
