import 'package:restaurant_app/data/model/restaurant_model.dart';

class RestaurantListResponse {
  RestaurantListResponse({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurantList,
  });

  final bool error;
  final String message;
  final int count;
  final List<RestaurantModel> restaurantList;

  factory RestaurantListResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantListResponse(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurantList: List<RestaurantModel>.from(
            json["restaurants"].map((x) => RestaurantModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants":
            List<dynamic>.from(restaurantList.map((x) => x.toJson())),
      };
}
