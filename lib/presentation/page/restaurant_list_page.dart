import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/presentation/bloc/home/home_bloc.dart';
import 'package:restaurant_app/presentation/page/widget/restaurant_item.dart';

class RestaurantListPage extends StatefulWidget {
  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  @override
  void initState() {
    Future.microtask(
      () => context.read<HomeBloc>().add(const LoadRestaurantList()),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: ((context, state) {
        if (state is HomeLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is HomeLoaded) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: state.restaurantList.length,
            itemBuilder: ((context, index) {
              final item = state.restaurantList[index];
              return RestaurantItem(
                id: item.id,
                name: item.name,
                imageUrl: item.pictureId,
                description: item.description,
                city: item.city,
                rating: item.rating,
              );
            }),
          );
        } else if (state is HomeError) {
          return Center(child: Text(state.message));
        } else {
          return const Text("");
        }
      }),
    );
  }
}
