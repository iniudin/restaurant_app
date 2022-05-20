part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchEmpty extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  const SearchLoaded(this.restaurants);

  final List<Restaurant> restaurants;

  @override
  List<Object> get props => [restaurants];
}

class SearchError extends SearchState {
  const SearchError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
