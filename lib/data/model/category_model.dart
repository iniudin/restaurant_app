import 'package:equatable/equatable.dart';
import 'package:restaurant_app/domain/entity/category.dart';

class CategoryModel extends Equatable {
  const CategoryModel({
    required this.name,
  });

  final String name;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };

  Category toEntity() => Category(name: name);

  @override
  List<Object?> get props => [name];
}
