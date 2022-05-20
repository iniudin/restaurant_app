import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_app/domain/entity/restaurant.dart';
import 'package:restaurant_app/domain/usecase/home.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeUsecase usecase;

  HomeBloc({
    required this.usecase,
  }) : super(HomeInitial()) {
    on<LoadRestaurantList>((event, emit) async {
      emit(
        HomeLoading(),
      );

      final result = await usecase.getRestaurantList();
      result.fold(
          (error) => emit(HomeError(error.message)),
          (restaurant) => restaurant.isNotEmpty
              ? emit(HomeLoaded(restaurant))
              : emit(const HomeNoData('No Data')));
    });
  }
}
