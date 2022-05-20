import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/restaurant_detail_model.dart';
import 'package:restaurant_app/data/model/restaurant_detail_response.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';
import 'package:restaurant_app/data/model/restaurant_model.dart';
import 'package:restaurant_app/data/model/restaurant_search_response.dart';

class ApiService {
  final http.Client _client;

  ApiService({http.Client? client}) : _client = client ?? http.Client();

  final baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<List<RestaurantModel>> getRestaurantList() async {
    final response = await _client.get(Uri.parse(baseUrl + '/list'));
    return RestaurantListResponse.fromJson(json.decode(response.body))
        .restaurantList;
  }

  Future<List<RestaurantModel>> searchRestaurants(String query) async {
    final response =
        await _client.get(Uri.parse(baseUrl + '/search?q=' + query));
    return RestaurantSearchResponse.fromJson(json.decode(response.body))
        .restaurantList;
  }

  Future<RestaurantDetailModel> getRestaurantDetail(String id) async {
    final response = await _client.get(Uri.parse(baseUrl + '/detail/' + id));
    return RestaurantDetailResponse.fromJson(json.decode(response.body))
        .restaurant;
  }
}
