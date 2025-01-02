part of 'form_bloc.dart';

abstract class FormEvent {}

class UpdateField extends FormEvent {
  final String field;
  final String value;
  UpdateField({required this.field, required this.value});
}
