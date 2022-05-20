import 'package:restaurant_app/data/helper/failure_exception.dart';
import 'package:restaurant_app/domain/entity/restaurant.dart';
import 'package:dartz/dartz.dart';
import 'package:restaurant_app/domain/entity/restaurant_detail.dart';

abstract class RestaurantRepository {
  Future<Either<FailureException, List<Restaurant>>> getRestaurantList();
  Future<Either<FailureException, List<Restaurant>>> searchRestaurants(
      String query);
  Future<Either<FailureException, RestaurantDetail>> getRestaurantDetail(
      String id);
  Future<Either<FailureException, List<Restaurant>>> getLocalRestaurants();
  Future<Either<FailureException, bool>> getLocalRestaurantByID(String id);
  Future<Either<FailureException, int>> insertLocalRestaurant(
      Restaurant restaurant);
  Future<Either<FailureException, int>> removeLocalRestaurant(
      Restaurant restaurant);
}
