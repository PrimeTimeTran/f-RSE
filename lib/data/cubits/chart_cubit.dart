import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:rse/data/all.dart';

abstract class ChartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChartHover extends ChartEvent {
  final String time;
  final double value;
  final double offset;
  final String type;
  final CandleStick candle;
  ChartHover(this.offset, this.time, this.value, this.candle, this.type);

  @override
  List<Object?> get props => [offset, time, value, candle, type];
}

abstract class ChartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HoveredChart extends ChartState {
  final String time;
  final double value;
  final double offset;
  final CandleStick candle;
  final String type;
  HoveredChart(this.offset, this.time, this.value, this.candle, this.type);

  @override
  List<Object?> get props => [offset, time, value, candle, type];
}

class ChartInitial extends ChartState {}

class ChartCubit extends Bloc<ChartEvent, ChartState> {
  ChartCubit() : super(ChartInitial()) {
    on<ChartHover>((event, emit) {
      emit(HoveredChart(event.offset, event.time, event.value, event.candle, event.type));
    });
  }

  void setHoveredPoint(point, double xOffSet) {
    if (point is CandleStick) {
      add(ChartHover(xOffSet, point.time, point.value, point, 'candle'));
    } else {
      add(ChartHover(xOffSet, point.x, point.y, CandleStick.defaultCandle(), 'portfolio'));

    }
  }
}
