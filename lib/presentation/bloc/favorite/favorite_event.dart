part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class GetRestaurants extends FavoriteEvent {
  const GetRestaurants();
}

class AddRestaurant extends FavoriteEvent {
  final Restaurant restaurant;

  const AddRestaurant(this.restaurant);

  @override
  List<Object> get props => [restaurant];
}

class IsBookmark extends FavoriteEvent {
  final Restaurant restaurant;

  const IsBookmark(this.restaurant);

  @override
  List<Object> get props => [restaurant];
}

class RemoveRestaurant extends FavoriteEvent {
  final Restaurant restaurant;

  const RemoveRestaurant(this.restaurant);

  @override
  List<Object> get props => [restaurant];
}
