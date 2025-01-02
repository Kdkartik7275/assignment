import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_assignment/core/utils/constants/colors.dart';
import 'package:internship_assignment/features/form/presentation/bloc/form_bloc.dart';

class FormDropdownField extends StatelessWidget {
  final String field;
  final String label;
  final List<String> options;

  const FormDropdownField({
    super.key,
    required this.field,
    required this.label,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloc, FormValidState>(
      builder: (context, state) {
        return DropdownButtonFormField<String>(
          dropdownColor: TColors.lightBG,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              color: TColors.lightAccent,
            ),
            hintStyle: TextStyle(
              color: TColors.lightAccent.withOpacity(0.7),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide:
                  BorderSide(color: TColors.lightPrimary.withOpacity(0.5)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: TColors.lightPrimary, width: 1.5),
              borderRadius: BorderRadius.circular(8.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: TColors.lightPrimary.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          value: state.fields[field],
          items: options
              .map((option) => DropdownMenuItem(
                    value: option,
                    child: Text(option),
                  ))
              .toList(),
          onChanged: (value) => context
              .read<FormBloc>()
              .add(UpdateField(field: field, value: value!)),
        );
      },
    );
  }
}
