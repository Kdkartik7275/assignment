import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_assignment/core/utils/cubit/home_cubit.dart';
import 'package:internship_assignment/core/utils/theme/theme.dart';
import 'package:internship_assignment/features/audioplayers/presentation/bloc/audio_bloc.dart';
import 'package:internship_assignment/features/form/presentation/bloc/form_bloc.dart';
import 'package:internship_assignment/features/products/presentation/bloc/products/products_bloc.dart';
import 'package:internship_assignment/home_view.dart';
import 'package:internship_assignment/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => sl<ProductsBloc>()),
    BlocProvider(create: (_) => FormBloc()),
    BlocProvider(create: (_) => HomeCubit()),
    BlocProvider(create: (_) => AudioBloc()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Products',
      theme: TTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const HomeView(),
    );
  }
}
