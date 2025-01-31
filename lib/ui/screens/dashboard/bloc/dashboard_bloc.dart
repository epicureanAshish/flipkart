import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  int currentIndex=0;

  DashboardBloc() : super(DashboardState(0)) {
    on<ChangeTabEvent>((event, emit) {
      currentIndex=event.index;
      emit(DashboardState(event.index));
    });
  }
}
