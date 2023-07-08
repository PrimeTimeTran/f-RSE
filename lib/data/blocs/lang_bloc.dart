import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LangEvent extends Equatable {
  final String locale;

  const LangEvent(this.locale);

  @override
  List<Object?> get props => [locale];
}

class LangState extends Equatable {
  final String locale;

  const LangState(this.locale);

  @override
  List<Object?> get props => [locale];
}

class LangBloc extends Bloc<LangEvent, LangState> {
  LangBloc() : super(const LangState('en')) {
    on<LangEvent>((event, emit) {
      emit(LangState(event.locale));
    });
  }

  void changeLang(String locale) {
    add(LangEvent(locale));
  }
}
