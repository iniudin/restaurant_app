import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/domain/entity/restaurant.dart';
import 'package:restaurant_app/presentation/bloc/search/search_bloc.dart';
import 'package:restaurant_app/utils/route/route_helper.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _textController = TextEditingController();
  late SearchBloc _searchBloc;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _searchBloc = context.read<SearchBloc>();
    super.initState();
  }

  void _onClearTapped() {
    _textController.text = '';
    _searchBloc.add(const TextChanged(query: ''));
  }

  Widget _buildSearchBar(BuildContext context) {
    return TextField(
      controller: _textController,
      autocorrect: false,
      onChanged: (query) {
        _searchBloc.add(TextChanged(query: query));
      },
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        suffixIcon: GestureDetector(
          onTap: _onClearTapped,
          child: const Icon(Icons.clear),
        ),
        border: InputBorder.none,
        hintText: 'Masukkan nama restaurant...',
      ),
    );
  }

  Widget _buildSearchBody(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is SearchLoaded) {
          return state.restaurants.isEmpty
              ? const Text("Tidak ditemukan")
              : Expanded(child: _buildList(context, state.restaurants));
        }
        if (state is SearchError) {
          return Center(child: Text(state.message));
        }
        return const Text(
          'Masukkan kata kunci restaurant',
        );
      },
    );
  }

  Widget _buildList(BuildContext context, List<Restaurant> restaurants) {
    return ListView.builder(
      itemCount: restaurants.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: SizedBox(
            width: 70,
            child: CachedNetworkImage(
              imageUrl: "https://restaurant-api.dicoding.dev/images/medium/" +
                  restaurants[index].pictureId,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(restaurants[index].name),
          subtitle: Text(
            restaurants[index].city,
          ),
          onTap: () {
            Navigator.pushNamed(context, detailRoute,
                arguments: Restaurant(
                  id: restaurants[index].id,
                  name: restaurants[index].name,
                  description: restaurants[index].description,
                  pictureId: restaurants[index].pictureId,
                  city: restaurants[index].city,
                  rating: restaurants[index].rating,
                ));
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cari Restaurant'),
      ),
      body: Column(
        children: <Widget>[
          _buildSearchBar(context),
          _buildSearchBody(context),
        ],
      ),
    );
  }
}
