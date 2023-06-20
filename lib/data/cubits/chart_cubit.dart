import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:rse/data/all.dart';

sealed class ChartEvent {}

class HoveredCandle extends ChartEvent {
  final CandleStick hoveredCandle;

  HoveredCandle(this.hoveredCandle);
}

class ChartCubit extends Bloc<ChartEvent, Chart> {
  double xOffSet = 0;
  ChartCubit(chart) : super(chart) {
    on<HoveredCandle>((event, emit) {
      final newChart = state.copyWith(hoveredCandle: event.hoveredCandle);
      emit(newChart);
    });
  }

  void setHoveredCandle(CandleStick hoveredCandle, double xOffSet) {
    this.xOffSet = xOffSet;
    emit(state.copyWith(hoveredCandle: hoveredCandle, xOffSet: xOffSet));
  }
}