import 'dart:async';

import 'package:bloc/bloc.dart';

part 'form_event.dart';
part 'form_state.dart';

class FormBloc extends Bloc<FormEvent, FormValidState> {
  FormBloc() : super(FormValidState(fields: {})) {
    on<UpdateField>(_updateField);
  }

  FutureOr<void> _updateField(UpdateField event, Emitter<FormValidState> emit) {
    final updatedFields = Map<String, String>.from(state.fields);
    updatedFields[event.field] = event.value;

    emit(state.copyWith(fields: updatedFields));
  }
}
