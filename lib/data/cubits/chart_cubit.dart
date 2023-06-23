import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:rse/data/all.dart';

abstract class ChartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChartInitialized extends ChartEvent {
  final double startValue;
  ChartInitialized(this.startValue);

  @override
  List<Object?> get props => [startValue];
}

class ChartUpdate extends ChartEvent {
  final String time;
  final String type;
  final double value;
  final double offset;
  final double startValue;
  final CandleStick candle;
  final double hoveredValue;
  ChartUpdate(this.offset, this.time, this.value, this.type, this.candle, this.hoveredValue, this.startValue);

  @override
  List<Object?> get props => [offset, time, value, candle, type, hoveredValue, startValue];
}

abstract class ChartState extends Equatable {
  @override
  List<Object?> get props => [];
}


class ChartInitial extends ChartState {
  final double startValue;
  ChartInitial(this.startValue);

  @override
  List<Object?> get props => [startValue];
}

class UpdatedChart extends ChartState {
  final String time;
  final String type;
  final double value;
  final double offset;
  final double startValue;
  final CandleStick candle;
  final double hoveredValue;
  UpdatedChart(this.offset, this.time, this.value, this.candle, this.type, this.hoveredValue, this.startValue);

  @override
  List<Object?> get props => [offset, time, value, candle, type, startValue];
}

class ChartCubit extends Bloc<ChartEvent, ChartState> {
  late double value = 0;
  late double xOffSet = 0;
  late double hoveredValue = 0;
  late double startValue = 100;
  late String type = 'portfolio';

  ChartCubit() : super(ChartInitial(0)) {
    on<ChartUpdate>((e, emit) {
      xOffSet = e.offset;
      emit(UpdatedChart(e.offset, e.time, e.value, e.candle, e.type, e.hoveredValue, e.startValue));
    });
    on<ChartInitialized>((e, emit) {
      emit(ChartInitial(e.startValue));
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
        hoveredValue,
        startValue
      )
    );
  }

  void initialChartLoad(start, current) {
    value = current;
    startValue = start;
  }
}
