import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:restaurant_app/presentation/page/widget/restaurant_item.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    Future.microtask(
      () => context.read<FavoriteBloc>().add(const GetRestaurants()),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: ((context, state) {
        if (state is FavoriteLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is FavoriteLoaded) {
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
        } else if (state is FavoriteError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text("Favorite Empty"));
        }
      }),
    );
  }
}
