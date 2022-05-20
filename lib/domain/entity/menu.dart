import 'package:equatable/equatable.dart';
import 'package:restaurant_app/domain/entity/category.dart';

class Menus extends Equatable {
  const Menus({
    required this.foods,
    required this.drinks,
  });

  final List<Category> foods;
  final List<Category> drinks;

  @override
  List<Object?> get props => [foods, drinks];
}
