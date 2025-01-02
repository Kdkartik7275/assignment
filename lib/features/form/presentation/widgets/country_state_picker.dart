import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_assignment/core/utils/constants/colors.dart';
import 'package:internship_assignment/features/form/presentation/bloc/form_bloc.dart';

class CountryStateCityPicker extends StatefulWidget {
  const CountryStateCityPicker({super.key});

  @override
  State<CountryStateCityPicker> createState() => _CountryStateCityPickerState();
}

class _CountryStateCityPickerState extends State<CountryStateCityPicker> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await Future.delayed(
        const Duration(milliseconds: 100)); // Simulate data fetch
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    String country = '';
    String state = '';
    String city = '';

    return SelectState(
      dropdownColor: TColors.lightBG,
      onCountryChanged: (value) {
        country = value;
        context
            .read<FormBloc>()
            .add(UpdateField(field: 'country', value: country));
      },
      onStateChanged: (value) {
        state = value;
        context.read<FormBloc>().add(UpdateField(field: 'state', value: state));
      },
      onCityChanged: (value) {
        city = value;
        context.read<FormBloc>().add(UpdateField(field: 'city', value: city));
      },
    );
  }
}
