import 'package:dartz/dartz.dart';
import 'package:restaurant_app/data/helper/failure_exception.dart';
import 'package:restaurant_app/domain/entity/restaurant_detail.dart';
import 'package:restaurant_app/domain/repository/restaurant_repository.dart';

class DetailUsecase {
  final RestaurantRepository repository;

  DetailUsecase(this.repository);

  Future<Either<FailureException, RestaurantDetail>> getRestaurantDetail(
      String id) {
    return repository.getRestaurantDetail(id);
  }
}
