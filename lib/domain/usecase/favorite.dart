import 'package:dartz/dartz.dart';
import 'package:restaurant_app/data/helper/failure_exception.dart';
import 'package:restaurant_app/domain/entity/restaurant.dart';
import 'package:restaurant_app/domain/repository/restaurant_repository.dart';

class FavoriteUsecase {
  final RestaurantRepository repository;

  FavoriteUsecase(this.repository);

  Future<Either<FailureException, List<Restaurant>>> getLocalRestaurants() {
    return repository.getLocalRestaurants();
  }

  Future<Either<FailureException, bool>> getLocalRestaurantById(String id) {
    return repository.getLocalRestaurantByID(id);
  }

  Future<Either<FailureException, int>> insertLocalRestaurant(
      Restaurant restaurant) {
    return repository.insertLocalRestaurant(restaurant);
  }

  Future<Either<FailureException, int>> removeLocalRestaurant(
      Restaurant restaurant) {
    return repository.removeLocalRestaurant(restaurant);
  }
}
