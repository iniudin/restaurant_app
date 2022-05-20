import 'package:restaurant_app/data/model/restaurant_model.dart';
import 'package:restaurant_app/data/service/database_service.dart';

abstract class RestaurantLocalDataSource {
  Future<int> insertRestaurantFavorite(RestaurantModel restaurantModel);
  Future<List<RestaurantModel>> getRestaurantList();
  Future<bool> getRestaurantById(String id);
  Future<int> removeRestaurantFavorite(RestaurantModel restaurantModel);
}

class RestaurantLocalDataSourceImpl extends RestaurantLocalDataSource {
  final DatabaseService databaseService;

  RestaurantLocalDataSourceImpl(this.databaseService);

  @override
  Future<List<RestaurantModel>> getRestaurantList() async {
    return await databaseService.getRestaurantList();
  }

  @override
  Future<bool> getRestaurantById(String id) async {
    return await databaseService.getRestaurantById(id);
  }

  @override
  Future<int> insertRestaurantFavorite(RestaurantModel restaurantModel) async {
    return await databaseService.insertRestaurantFavorite(restaurantModel);
  }

  @override
  Future<int> removeRestaurantFavorite(RestaurantModel restaurantModel) async {
    return await databaseService.removeRestaurantFavorite(restaurantModel);
  }
}
