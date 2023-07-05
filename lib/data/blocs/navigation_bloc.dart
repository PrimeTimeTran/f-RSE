import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

abstract class NavEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class NavChanged extends NavEvent {
  final String location;

  NavChanged(this.location);

  @override
  List<Object?> get props => [location];
}

abstract class NavState extends Equatable {
  List<int> get states;
}

class NavChangeSuccess extends NavState {
  final String location;
  @override
  final List<int> states;

  NavChangeSuccess(this.location, this.states);

  @override
  List<Object?> get props => [location, states];
}

final defaultStates = [0, 0, 0, 0];

class NavBloc extends Bloc<NavEvent, NavState> {
  final tabStates = defaultStates;
  NavBloc() : super(NavChangeSuccess('0-0', defaultStates)) {
    on<NavChanged>((e, emit) async {
      final indexes = e.location.split('-');
      tabStates[int.parse(indexes[0])] = int.parse(indexes[1]);
      emit(NavChangeSuccess(e.location, tabStates));
    });
  }
}