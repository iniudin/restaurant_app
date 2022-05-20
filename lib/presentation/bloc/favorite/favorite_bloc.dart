import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_app/domain/entity/restaurant.dart';
import 'package:restaurant_app/domain/usecase/favorite.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteUsecase usecase;
  FavoriteBloc({required this.usecase}) : super(FavoriteInitial()) {
    on<GetRestaurants>((event, emit) async {
      emit(
        FavoriteLoading(),
      );
      final result = await usecase.getLocalRestaurants();
      result.fold(
          (error) => emit(FavoriteError(error.message)),
          (restaurant) => restaurant.isNotEmpty
              ? emit(FavoriteLoaded(restaurant))
              : emit(const FavoriteNodata('Favorite empty.')));
    });

    on<AddRestaurant>((event, emit) async {
      final restaurant = event.restaurant;

      emit(
        FavoriteLoading(),
      );

      final result = await usecase.insertLocalRestaurant(restaurant);
      result.fold(
        (error) => emit(
          FavoriteError(error.message),
        ),
        (success) => add(IsBookmark(restaurant)),
      );
    });

    on<RemoveRestaurant>((event, emit) async {
      final restaurant = event.restaurant;

      emit(
        FavoriteLoading(),
      );

      final result = await usecase.removeLocalRestaurant(restaurant);
      result.fold(
        (error) => emit(
          FavoriteError(error.message),
        ),
        (success) => add(IsBookmark(restaurant)),
      );
    });

    on<IsBookmark>((event, emit) async {
      final id = event.restaurant.id;

      emit(
        FavoriteLoading(),
      );

      final result = await usecase.getLocalRestaurantById(id);
      result.fold(
        (error) => emit(FavoriteError(error.message)),
        (success) => emit(FavoriteIsBookmark(success)),
      );
    });
  }
}
