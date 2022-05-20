part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class RestaurantSetEmpty extends SearchEvent {}

class TextChanged extends SearchEvent {
  final String query;

  const TextChanged({required this.query});

  @override
  List<Object> get props => [query];
}
