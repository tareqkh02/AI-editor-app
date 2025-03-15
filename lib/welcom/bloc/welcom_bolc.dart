import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:AI_editor_app/welcom/bloc/welcom_event.dart';
import 'package:AI_editor_app/welcom/bloc/welcom_state.dart';

class WeclomBloc extends Bloc<WelcomEvent, WelcomState> {
  WeclomBloc() : super(WelcomState()) {
    on<WelcomEvent>((event, emit) => emit(WelcomState(page: state.page)));
  }
}
