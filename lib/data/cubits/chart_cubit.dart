import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:rse/data/all.dart';

abstract class ChartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChartHover extends ChartEvent {
  final String time;
  final String type;
  final double value;
  final double offset;
  final CandleStick candle;
  ChartHover(this.offset, this.time, this.value, this.type, this.candle);

  @override
  List<Object?> get props => [offset, time, value, candle, type];
}

abstract class ChartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HoveredChart extends ChartState {
  final String time;
  final String type;
  final double value;
  final double offset;
  final CandleStick candle;
  HoveredChart(this.offset, this.time, this.value, this.candle, this.type);

  @override
  List<Object?> get props => [offset, time, value, candle, type];
}

class ChartInitial extends ChartState {}

class ChartCubit extends Bloc<ChartEvent, ChartState> {
  ChartCubit() : super(ChartInitial()) {
    on<ChartHover>((e, emit) {
      emit(HoveredChart(e.offset, e.time, e.value, e.candle, e.type));
    });
  }

  void setHoveredPoint(p, double xOffSet) {
    var candle = p is CandleStick;
    add(ChartHover(
        xOffSet,
        candle ? p.time : p.x,
        candle ? p.value : p.y,
        candle ? 'candle' : 'portfolio',
        candle ? p : CandleStick.fact(),
      )
    );
  }
}
