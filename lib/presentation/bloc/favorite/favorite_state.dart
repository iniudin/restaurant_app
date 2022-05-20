part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<Restaurant> restaurantList;

  const FavoriteLoaded(this.restaurantList);

  @override
  List<Object> get props => [restaurantList];
}

class FavoriteNodata extends FavoriteState {
  final String message;

  const FavoriteNodata(this.message);

  @override
  List<Object> get props => [message];
}

class FavoriteError extends FavoriteState {
  final String message;

  const FavoriteError(this.message);
  @override
  List<Object> get props => [message];
}

class FavoriteIsBookmark extends FavoriteState {
  final bool isBookmark;

  const FavoriteIsBookmark(this.isBookmark);

  @override
  List<Object> get props => [isBookmark];
}
