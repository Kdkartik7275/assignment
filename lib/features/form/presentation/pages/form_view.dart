import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_assignment/core/utils/constants/colors.dart';
import 'package:internship_assignment/features/form/presentation/bloc/form_bloc.dart';
import 'package:internship_assignment/features/form/presentation/widgets/country_state_picker.dart';
import 'package:internship_assignment/features/form/presentation/widgets/gender_dropdown.dart';
import 'package:internship_assignment/features/form/presentation/widgets/text_field.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 4.0,
            color: TColors.lightBG,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Fill Your Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff886EE4),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const FormTextField(
                    field: 'name',
                    label: 'Name',
                    hintText: 'Enter your name',
                  ),
                  const SizedBox(height: 12),
                  const FormTextField(
                    field: 'email',
                    label: 'Email',
                    hintText: 'Enter your email',
                  ),
                  const SizedBox(height: 12),
                  const FormTextField(
                    field: 'phone',
                    label: 'Phone',
                    hintText: 'Enter your phone number',
                  ),
                  const SizedBox(height: 12),
                  const FormDropdownField(
                    field: 'gender',
                    label: 'Gender',
                    options: ['Male', 'Female', 'Other'],
                  ),
                  const SizedBox(height: 12),
                  const CountryStateCityPicker(),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TColors.lightAccent,
                      foregroundColor: TColors.lightPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final formState = context.read<FormBloc>().state;

                        final gender = formState.fields['gender'];
                        final country = formState.fields['country'];
                        final stateField = formState.fields['state'];
                        final city = formState.fields['city'];

                        if (gender == null ||
                            country == null ||
                            stateField == null ||
                            city == null ||
                            gender.isEmpty ||
                            country.isEmpty ||
                            stateField.isEmpty ||
                            city.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Please fill all the required fields.'),
                            ),
                          );
                          return;
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Form submitted successfully!'),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
