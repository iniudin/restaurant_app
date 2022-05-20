import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/domain/entity/category.dart';
import 'package:restaurant_app/domain/entity/restaurant.dart';
import 'package:restaurant_app/domain/entity/restaurant_detail.dart';
import 'package:restaurant_app/presentation/bloc/detail/detail_bloc.dart';
import 'package:restaurant_app/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:restaurant_app/utils/route/route_observer_helper.dart';

class RestaurantDetailPage extends StatefulWidget {
  final Restaurant arguments;

  const RestaurantDetailPage({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage>
    with RouteAware {
  @override
  void initState() {
    Future.microtask(() =>
        context.read<DetailBloc>().add(DetailRestaurant(widget.arguments.id)));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    routeObserver.subscribe(this, ModalRoute.of(context)!);
    super.didChangeDependencies();
  }

  @override
  void didPop() {
    Future.microtask(() {
      context.read<FavoriteBloc>().add(
            const GetRestaurants(),
          );
    });
    super.didPop();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.arguments.name),
        actions: [
          BlocConsumer<DetailBloc, DetailState>(
            listener: (context, detailState) {
              if (detailState is DetailLoaded) {
                final restaurant = Restaurant(
                  id: widget.arguments.id,
                  name: widget.arguments.name,
                  description: widget.arguments.description,
                  pictureId: widget.arguments.pictureId,
                  city: widget.arguments.city,
                  rating: widget.arguments.rating,
                );
                context.read<FavoriteBloc>().add(IsBookmark(restaurant));
              }
            },
            builder: (context, detailState) {
              return BlocBuilder<FavoriteBloc, FavoriteState>(
                builder: (context, databaseState) {
                  final restaurant = Restaurant(
                    id: widget.arguments.id,
                    name: widget.arguments.name,
                    description: widget.arguments.description,
                    pictureId: widget.arguments.pictureId,
                    city: widget.arguments.city,
                    rating: widget.arguments.rating,
                  );

                  final isBookmarked = (context.watch<FavoriteBloc>().state
                          is FavoriteIsBookmark)
                      ? (context.read<FavoriteBloc>().state
                              as FavoriteIsBookmark)
                          .isBookmark
                      : false;

                  return IconButton(
                    onPressed: () {
                      if (isBookmarked) {
                        context
                            .read<FavoriteBloc>()
                            .add(RemoveRestaurant(restaurant));
                      } else {
                        context
                            .read<FavoriteBloc>()
                            .add(AddRestaurant(restaurant));
                      }
                    },
                    icon: isBookmarked
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : const Icon(Icons.favorite_border),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<DetailBloc, DetailState>(
          builder: ((context, state) {
            if (state is DetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DetailLoaded) {
              return _buildDetail(context, state.restaurantDetail);
            } else if (state is DetailError) {
              return Center(child: Text(state.message));
            } else {
              return const Text("");
            }
          }),
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context, imageUrl) {
    return Hero(
      tag: imageUrl,
      child: CachedNetworkImage(
        imageUrl:
            "https://restaurant-api.dicoding.dev/images/large/" + imageUrl,
        placeholder: (context, imageUrl) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, imageUrl, error) => const Icon(Icons.error),
      ),
    );
  }

  Widget _buildTitle(BuildContext context, RestaurantDetail restaurantDetail) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              restaurantDetail.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${restaurantDetail.address}, ${restaurantDetail.city}",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Row(
                  children: [
                    const Icon(Icons.star),
                    Text(
                      restaurantDetail.rating.toString(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategory(
      BuildContext context, RestaurantDetail restaurantDetail) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Kategori",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8.0),
            Row(
              children: <Widget>[
                ...restaurantDetail.categories.map(((e) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(e.name),
                  );
                })).toList()
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescription(
      BuildContext context, RestaurantDetail restaurantDetail) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Deskripsi",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8.0),
            Text(
              restaurantDetail.description,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenus(BuildContext context, List<Category> menus, String title) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Wrap(
              spacing: 4.0,
              runSpacing: 4.0,
              children: [
                ...menus.map((e) {
                  return Card(
                    elevation: 2,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(e.name,
                            style: Theme.of(context).textTheme.titleSmall)),
                  );
                }).toList(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetail(BuildContext context, RestaurantDetail restaurantDetail) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildImage(context, restaurantDetail.pictureId),
        _buildTitle(context, restaurantDetail),
        _buildCategory(context, restaurantDetail),
        _buildDescription(context, restaurantDetail),
        if (restaurantDetail.menus.foods.isNotEmpty)
          _buildMenus(context, restaurantDetail.menus.foods, "Masakan")
        else
          const Text("Masakan Tidak tersedia"),
        if (restaurantDetail.menus.drinks.isNotEmpty)
          _buildMenus(context, restaurantDetail.menus.drinks, "Minuman")
        else
          const Text("Minuman Tidak tersedia"),
      ],
    );
  }
}
