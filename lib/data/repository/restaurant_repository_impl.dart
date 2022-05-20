import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';

import 'package:restaurant_app/data/source/local_data_source.dart';
import 'package:restaurant_app/data/source/remote_data_source.dart';
import 'package:restaurant_app/domain/entity/restaurant_detail.dart';
import 'package:restaurant_app/domain/entity/restaurant.dart';
import 'package:restaurant_app/data/helper/failure_exception.dart';
import 'package:restaurant_app/domain/repository/restaurant_repository.dart';
import 'package:restaurant_app/data/model/restaurant_model.dart';

class RestaurantRepositoryImpl extends RestaurantRepository {
  final RestaurantRemoteDataSource remoteDataSource;
  final RestaurantLocalDataSource localDataSource;

  RestaurantRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<FailureException, List<Restaurant>>>
      getLocalRestaurants() async {
    try {
      final result = await localDataSource.getRestaurantList();
      return Right(result.map((e) => e.toEntity()).toList());
    } on DatabaseException {
      return const Left(FailureException('Failed connect to database'));
    }
  }

  @override
  Future<Either<FailureException, bool>> getLocalRestaurantByID(
      String id) async {
    try {
      final result = await localDataSource.getRestaurantById(id);
      return Right(result);
    } on DatabaseException {
      return const Left(FailureException('Failed connect to database'));
    }
  }

  @override
  Future<Either<FailureException, RestaurantDetail>> getRestaurantDetail(
      String id) async {
    try {
      final result = await remoteDataSource.getRestaurantDetail(id);
      return Right(result.toEntity());
    } on SocketException {
      return const Left(FailureException('No internet connection'));
    } catch (e) {
      return const Left(FailureException('Failed to load Restaurant Lsit'));
    }
  }

  @override
  Future<Either<FailureException, List<Restaurant>>> getRestaurantList() async {
    try {
      final result = await remoteDataSource.getRestaurantList();
      return Right(result.map((e) => e.toEntity()).toList());
    } on SocketException {
      return const Left(FailureException('No internet connection'));
    } catch (e) {
      return const Left(FailureException('Failed to load Restaurant Lsit'));
    }
  }

  @override
  Future<Either<FailureException, int>> insertLocalRestaurant(
      Restaurant restaurant) async {
    try {
      final result = await localDataSource
          .insertRestaurantFavorite(RestaurantModel.fromEntity(restaurant));
      return Right(result);
    } on DatabaseException {
      return const Left(FailureException('Failed connect to database'));
    }
  }

  @override
  Future<Either<FailureException, int>> removeLocalRestaurant(
      Restaurant restaurant) async {
    try {
      final result = await localDataSource
          .removeRestaurantFavorite(RestaurantModel.fromEntity(restaurant));
      return Right(result);
    } on DatabaseException {
      return const Left(FailureException('Failed connect to database'));
    }
  }

  @override
  Future<Either<FailureException, List<Restaurant>>> searchRestaurants(
      String query) async {
    try {
      final result = await remoteDataSource.searchRestaurant(query);
      return Right(result.map((e) => e.toEntity()).toList());
    } on SocketException {
      return const Left(FailureException('No internet connection'));
    } catch (e) {
      return const Left(FailureException('Failed to load Restaurant Lsit'));
    }
  }
}
