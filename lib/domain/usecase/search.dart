import 'package:dartz/dartz.dart';
import 'package:restaurant_app/data/helper/failure_exception.dart';
import 'package:restaurant_app/domain/entity/restaurant.dart';
import 'package:restaurant_app/domain/repository/restaurant_repository.dart';

class SearchUsecase {
  final RestaurantRepository repository;

  SearchUsecase(this.repository);

  Future<Either<FailureException, List<Restaurant>>> searchRestaurants(
      String query) {
    return repository.searchRestaurants(query);
  }
}
