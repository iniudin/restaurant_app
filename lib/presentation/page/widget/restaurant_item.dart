import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/domain/entity/restaurant.dart';
import 'package:restaurant_app/utils/route/route_helper.dart';

class RestaurantItem extends StatelessWidget {
  final String id;
  final String name;
  final String imageUrl;
  final String city;
  final String description;
  final double rating;

  const RestaurantItem({
    Key? key,
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.city,
    required this.description,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          detailRoute,
          arguments: Restaurant(
            id: id,
            name: name,
            description: description,
            pictureId: imageUrl,
            city: city,
            rating: rating,
          ),
        );
      },
      child: Card(
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: CachedNetworkImage(
                imageUrl: "https://restaurant-api.dicoding.dev/images/medium/" +
                    imageUrl,
                height: 90,
                width: 200,
                fit: BoxFit.cover,
                placeholder: (context, imageUrl) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, imageUrl, error) =>
                    const Icon(Icons.error),
              ),
            ),
            ListTile(
              title: Text(
                name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                city,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
