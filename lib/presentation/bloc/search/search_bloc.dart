import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_app/domain/entity/restaurant.dart';
import 'package:restaurant_app/domain/usecase/search.dart';
import 'package:stream_transform/stream_transform.dart';

part 'search_event.dart';
part 'search_state.dart';

const _duration = Duration(milliseconds: 300);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchUsecase usecase;
  SearchBloc({required this.usecase}) : super(SearchEmpty()) {
    on<TextChanged>(_onTextChanged, transformer: debounce(_duration));
  }

  void _onTextChanged(
    TextChanged event,
    Emitter<SearchState> emit,
  ) async {
    final searchTerm = event.query;

    if (searchTerm.isEmpty) return emit(SearchEmpty());

    emit(SearchLoading());

    final result = await usecase.searchRestaurants(searchTerm);
    result.fold(
        (error) => emit(SearchError(error.message)),
        (restaurant) => restaurant.isNotEmpty
            ? emit(SearchLoaded(restaurant))
            : emit(const SearchError('No Data')));
  }
}
