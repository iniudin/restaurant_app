import 'package:equatable/equatable.dart';
import 'package:restaurant_app/data/model/restaurant_detail_model.dart';

class RestaurantDetailResponse extends Equatable {
  const RestaurantDetailResponse({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  final bool error;
  final String message;
  final RestaurantDetailModel restaurant;

  factory RestaurantDetailResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantDetailResponse(
        error: json["error"],
        message: json["message"],
        restaurant: RestaurantDetailModel.fromJson(json["restaurant"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "restaurant": restaurant.toJson(),
      };

  @override
  List<Object?> get props => [error, message, restaurant];
}
