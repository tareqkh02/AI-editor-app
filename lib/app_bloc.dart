import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:AI_editor_app/app_event.dart';
import 'package:AI_editor_app/app_state.dart';

class Appbloc extends Bloc<appEvent, AppState> {
  Appbloc() : super(Initstate()) {
    on<increment>(
      (event, emit) {
        emit(AppState(count: state.count + 1));
      },
    );
  }
}
