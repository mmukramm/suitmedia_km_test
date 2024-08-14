import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:suitmedia_km_test/bloc/username/username_event.dart';

class UsernameBloc extends Bloc<UsernameEvent, String> {
  UsernameBloc() : super('Selected Username') {
    on<ChangeUsername>(onChangeUsername);
  }

  FutureOr<void> onChangeUsername(
    ChangeUsername event,
    Emitter<String> emit,
  ) async {
    emit(event.username);
  }
}
