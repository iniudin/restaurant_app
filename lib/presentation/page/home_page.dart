import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/presentation/bloc/home/home_index_cubit.dart';
import 'package:restaurant_app/presentation/page/favorite_page.dart';
import 'package:restaurant_app/presentation/page/restaurant_list_page.dart';
import 'package:restaurant_app/presentation/page/settings_page.dart';
import 'package:restaurant_app/utils/route/route_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _listPage = [
    const RestaurantListPage(),
    const FavoritePage(),
    const SettingPage(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.restaurant),
      label: "Rekomendasi",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: "Favorit",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: "Pengaturan",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurant"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, searchRoute);
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: _listPage[context.watch<HomeIndexCubit>().state],
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavBarItems,
        currentIndex: context.watch<HomeIndexCubit>().state,
        onTap: (index) {
          context.read<HomeIndexCubit>().setIndexPage(index);
        },
      ),
    );
  }
}
