import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:internship_assignment/core/utils/constants/colors.dart';
import 'package:internship_assignment/core/utils/cubit/home_cubit.dart';
import 'package:internship_assignment/features/audioplayers/presentation/pages/audio_player_view.dart';
import 'package:internship_assignment/features/form/presentation/pages/form_view.dart';
import 'package:internship_assignment/features/products/presentation/bloc/products/products_bloc.dart';
import 'package:internship_assignment/features/products/presentation/pages/products_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ZoomDrawerController _zoomDrawerController = ZoomDrawerController();

  @override
  void initState() {
    context.read<ProductsBloc>().add(OnFetchProducts());
    super.initState();
  }

  final List<Widget> pages = [
    const ProductsView(),
    const FormPage(),
    AudioPlayerPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZoomDrawer(
        drawerShadowsBackgroundColor: TColors.lightAccent,
        controller: _zoomDrawerController,
        menuScreen: buildMenuScreen(),
        mainScreen: BlocBuilder<HomeCubit, int>(
          builder: (context, currentIndex) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  currentIndex == 0
                      ? 'Products Page'
                      : currentIndex == 1
                          ? 'Form Validation'
                          : 'Audio Player',
                  style: TextStyle(color: TColors.lightBG),
                ),
                backgroundColor: TColors.darkAccent,
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(Icons.menu, color: TColors.lightPrimary),
                  onPressed: () {
                    _zoomDrawerController.toggle!();
                  },
                ),
              ),
              body: pages[currentIndex],
            );
          },
        ),
        borderRadius: 24.0,
        showShadow: true,
        angle: 0.0,
        slideWidth: MediaQuery.of(context).size.width * 0.65,
      ),
    );
  }

  Widget buildMenuScreen() {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              TColors.lightPrimary.withOpacity(0.8),
              TColors.lightPrimary.withOpacity(0.4),
            ],
          ),
        ),
        child: Column(
          children: [
            buildHeader(),
            Divider(
              thickness: 1,
              color: Colors.grey.shade300,
              indent: 16,
              endIndent: 16,
            ),
            buildMenuItems(),
            const Spacer(),
            Divider(
              thickness: 1,
              color: Colors.grey.shade300,
              indent: 16,
              endIndent: 16,
            ),
            buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: TColors.lightPrimary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/images/flag.jpg'),
          ),
          const SizedBox(width: 16),
          Text(
            'Kartik',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: TColors.lightAccent,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuItems() {
    return Column(
      children: [
        ListTile(
          title: Text("Home", style: TextStyle(color: TColors.lightAccent)),
          leading: Icon(Icons.home, color: TColors.lightAccent),
          onTap: () {
            _zoomDrawerController.close!();
            context.read<HomeCubit>().changeIndex(0);
          },
        ),
        ListTile(
          title: Text("Form Validation",
              style: TextStyle(color: TColors.lightAccent)),
          leading: Icon(Icons.assignment, color: TColors.lightAccent),
          onTap: () {
            _zoomDrawerController.close!();
            context.read<HomeCubit>().changeIndex(1);
          },
        ),
        ListTile(
          title: Text("Audio Player",
              style: TextStyle(color: TColors.lightAccent)),
          leading: Icon(Icons.audiotrack, color: TColors.lightAccent),
          onTap: () {
            _zoomDrawerController.close!();
            context.read<HomeCubit>().changeIndex(2);
          },
        ),
      ],
    );
  }

  Widget buildFooter() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Icon(Icons.settings, color: TColors.lightAccent),
          const SizedBox(width: 10),
          Text(
            'Settings',
            style: TextStyle(
              color: TColors.lightAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
