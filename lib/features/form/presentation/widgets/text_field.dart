import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_assignment/core/utils/constants/colors.dart';
import 'package:internship_assignment/features/form/presentation/bloc/form_bloc.dart';

class FormTextField extends StatelessWidget {
  final String field;
  final String label;
  final String hintText;

  const FormTextField({
    super.key,
    required this.field,
    required this.label,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: field == 'email'
          ? TextInputType.emailAddress
          : field == 'phone'
              ? TextInputType.phone
              : TextInputType.name,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        labelStyle: TextStyle(
          color: TColors.lightAccent,
        ),
        hintStyle: TextStyle(
          color: TColors.lightAccent.withOpacity(0.7),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: TColors.lightPrimary.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: TColors.lightPrimary, width: 1.5),
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: TColors.lightPrimary.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(8.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
          borderRadius: BorderRadius.circular(8.0),
        ),
        fillColor: TColors.lightBG,
        filled: true,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$label cannot be empty';
        }

        if (field == 'email' &&
            !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Enter a valid email';
        }

        if (field == 'phone' && !RegExp(r'^\d{10}$').hasMatch(value)) {
          return 'Enter a valid 10-digit phone number';
        }

        return null;
      },
      onChanged: (value) {
        context.read<FormBloc>().add(UpdateField(field: field, value: value));
      },
    );
  }
}
