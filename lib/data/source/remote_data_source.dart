import 'package:restaurant_app/data/model/restaurant_detail_model.dart';
import 'package:restaurant_app/data/model/restaurant_model.dart';
import 'package:restaurant_app/data/service/api_service.dart';

abstract class RestaurantRemoteDataSource {
  Future<List<RestaurantModel>> getRestaurantList();
  Future<RestaurantDetailModel> getRestaurantDetail(String id);
  Future<List<RestaurantModel>> searchRestaurant(String query);
}

class RestaurantRemoteDataSourceImpl implements RestaurantRemoteDataSource {
  final ApiService apiService;

  RestaurantRemoteDataSourceImpl(this.apiService);

  @override
  Future<RestaurantDetailModel> getRestaurantDetail(String id) async {
    return await apiService.getRestaurantDetail(id);
  }

  @override
  Future<List<RestaurantModel>> getRestaurantList() async {
    return await apiService.getRestaurantList();
  }

  @override
  Future<List<RestaurantModel>> searchRestaurant(String query) async {
    return await apiService.searchRestaurants(query);
  }
}
