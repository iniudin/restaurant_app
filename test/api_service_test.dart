import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/model/restaurant_detail_model.dart';
import 'package:restaurant_app/data/model/restaurant_model.dart';
import 'package:restaurant_app/data/service/api_service.dart';

import 'api_service_test.mocks.dart';
import 'dart:io';

String readJson(String name) {
  final data = File('test/$name').readAsStringSync();
  return data;
}

@GenerateMocks([http.Client])
void main() {
  final client = MockClient();

  group('Get RestaurantList', () {
    test('returns restaurantList if the http call completes successfully',
        () async {
      when(client.get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
          .thenAnswer((_) async =>
              http.Response(readJson("json/restaurant_list.json"), 200));

      expect(await ApiService(client: client).getRestaurantList(),
          isA<List<RestaurantModel>>());
    });
  });
  group('Get RestaurantDetail', () {
    test('returns RestaurantDetail if the http call completes successfully',
        () async {
      when(
        client.get(
          Uri.parse(
              'https://restaurant-api.dicoding.dev/detail/rqdv5juczeskfw1e867'),
        ),
      ).thenAnswer((_) async =>
          http.Response(readJson("json/restaurant_detail.json"), 200));

      expect(
          await ApiService(client: client)
              .getRestaurantDetail("rqdv5juczeskfw1e867"),
          isA<RestaurantDetailModel>());
    });
  });

  group('Search Restaurant', () {
    test('returns result of search if the http call completes successfully',
        () async {
      when(
        client.get(
          Uri.parse('https://restaurant-api.dicoding.dev/search?q=kota'),
        ),
      ).thenAnswer((_) async =>
          http.Response(readJson("json/restaurant_search.json"), 200));

      expect(await ApiService(client: client).searchRestaurants("kota"),
          isA<List<RestaurantModel>>());
    });
  });
}
