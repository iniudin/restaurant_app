import 'package:flutter/material.dart';
import 'package:restaurant_app/domain/entity/restaurant.dart';
import 'package:restaurant_app/presentation/page/home_page.dart';
import 'package:restaurant_app/presentation/page/restaurant_detail_page.dart';
import 'package:restaurant_app/presentation/page/search_page.dart';
import 'package:restaurant_app/presentation/page/unknown_page.dart';

part 'route_name_helper.dart';

class RouteHelper {
  static Route<dynamic>? generateRoute(RouteSettings? settings) {
    final routeName = settings?.name;
    final arguments = settings?.arguments;

    switch (routeName) {
      case homeRoute:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
          settings: settings,
        );
      case detailRoute:
        if (arguments is Restaurant) {
          return MaterialPageRoute(
            builder: (_) => RestaurantDetailPage(arguments: arguments),
            settings: settings,
          );
        }
        return MaterialPageRoute(builder: (_) => const UnknownPage());
      case searchRoute:
        return MaterialPageRoute(
          builder: (_) => const SearchPage(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(builder: (_) => const UnknownPage());
    }
  }
}
