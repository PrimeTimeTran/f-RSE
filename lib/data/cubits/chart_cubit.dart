import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:rse/data/all.dart';

abstract class ChartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChartUpdate extends ChartEvent {
  final String time;
  final String type;
  final double value;
  final double offset;
  final CandleStick candle;
  final double hoveredValue;
  ChartUpdate(this.offset, this.time, this.value, this.type, this.candle, this.hoveredValue);

  @override
  List<Object?> get props => [offset, time, value, candle, type, hoveredValue];
}

abstract class ChartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdatedChart extends ChartState {
  final String time;
  final String type;
  final double value;
  final double offset;
  final CandleStick candle;
  final double hoveredValue;
  UpdatedChart(this.offset, this.time, this.value, this.candle, this.type, this.hoveredValue);

  @override
  List<Object?> get props => [offset, time, value, candle, type];
}

class ChartInitial extends ChartState {}

class ChartCubit extends Bloc<ChartEvent, ChartState> {
  late double xOffSet = 0;
  late double value = 0;
  late double hoveredValue = 0;
  late String type = 'portfolio';

  ChartCubit() : super(ChartInitial()) {
    on<ChartUpdate>((e, emit) {
      xOffSet = e.offset;
      emit(UpdatedChart(e.offset, e.time, e.value, e.candle, e.type, e.hoveredValue));
    });
  }

  void setHoveredPoint(p, double xOffSet) {
    var candle = p is CandleStick;
    type = candle ? 'candle' : 'portfolio';
    value = candle ? p.value : p.y;
    add(ChartUpdate(
        xOffSet,
        candle ? p.time : p.x,
        candle ? p.value : p.y,
        type,
        candle ? p : CandleStick.fact(),
        hoveredValue
      )
    );
  }

  void chartLoaded(value) {
    hoveredValue = value;
    add(ChartUpdate(
      xOffSet,
      DateTime.now().toString(),
      value,
      type,
      CandleStick.fact(),
      value
    ));
  }
}
