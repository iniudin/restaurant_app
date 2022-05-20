import 'package:equatable/equatable.dart';
import 'package:restaurant_app/data/model/restaurant_model.dart';

class RestaurantSearchResponse extends Equatable {
  const RestaurantSearchResponse({
    required this.error,
    required this.founded,
    required this.restaurantList,
  });

  final bool error;
  final int founded;
  final List<RestaurantModel> restaurantList;

  factory RestaurantSearchResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantSearchResponse(
        error: json["error"],
        founded: json["founded"],
        restaurantList: List<RestaurantModel>.from(
            json["restaurants"].map((x) => RestaurantModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants":
            List<dynamic>.from(restaurantList.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [error, founded, restaurantList];
}
