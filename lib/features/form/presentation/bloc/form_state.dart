part of 'form_bloc.dart';

class FormValidState {
  final Map<String, String> fields;
  FormValidState({required this.fields});

  FormValidState copyWith({Map<String, String>? fields}) {
    return FormValidState(
      fields: fields ?? this.fields,
    );
  }
}
