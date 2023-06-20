import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:rse/data/all.dart';

abstract class ChartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class HoveredCandle extends ChartEvent {
  final double xOffSet;
  final CandleStick hoveredCandle;

  HoveredCandle(this.hoveredCandle, this.xOffSet);

  @override
  List<Object?> get props => [hoveredCandle, xOffSet];
}

abstract class ChartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HoveredCandleState extends ChartState {
  final double xOffSet;
  final CandleStick hoveredCandle;

  HoveredCandleState(this.hoveredCandle, this.xOffSet);

  @override
  List<Object?> get props => [hoveredCandle, xOffSet];
}

class ChartInitial extends ChartState {}

class ChartCubit extends Bloc<ChartEvent, ChartState> {
  ChartCubit() : super(ChartInitial()) {
    on<HoveredCandle>((event, emit) {
      emit(HoveredCandleState(event.hoveredCandle, event.xOffSet));
    });
  }

  void setHoveredCandle(CandleStick candle, double xOffSet) {
    add(HoveredCandle(candle, xOffSet));
  }
}
