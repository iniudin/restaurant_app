import 'package:dartz/dartz.dart';
import 'package:restaurant_app/data/helper/failure_exception.dart';
import 'package:restaurant_app/domain/entity/restaurant.dart';
import 'package:restaurant_app/domain/repository/restaurant_repository.dart';

class HomeUsecase {
  final RestaurantRepository repository;

  HomeUsecase(this.repository);

  Future<Either<FailureException, List<Restaurant>>> getRestaurantList() {
    return repository.getRestaurantList();
  }
}
