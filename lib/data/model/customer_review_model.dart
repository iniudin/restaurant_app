import 'package:equatable/equatable.dart';
import 'package:restaurant_app/domain/entity/customer_review.dart';

class CustomerReviewModel extends Equatable {
  const CustomerReviewModel({
    required this.name,
    required this.review,
    required this.date,
  });

  final String name;
  final String review;
  final String date;

  factory CustomerReviewModel.fromJson(Map<String, dynamic> json) =>
      CustomerReviewModel(
        name: json["name"],
        review: json["review"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "review": review,
        "date": date,
      };

  CustomerReview toEntity() => CustomerReview(
        name: name,
        review: review,
        date: date,
      );

  @override
  List<Object?> get props => [name, review, date];
}
