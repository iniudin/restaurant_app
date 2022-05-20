import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_app/domain/entity/restaurant_detail.dart';
import 'package:restaurant_app/domain/usecase/detail.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final DetailUsecase usecase;

  DetailBloc({
    required this.usecase,
  }) : super(DetailInitial()) {
    on<DetailRestaurant>((event, emit) async {
      emit(DetailLoading());
      final id = event.id;
      final result = await usecase.getRestaurantDetail(id);
      result.fold(
          (error) => emit(DetailError(error.message)),
          (restaurant) => restaurant.props.isNotEmpty
              ? emit(DetailLoaded(restaurant))
              : emit(const DetailNoData('No Data')));
    });
  }
}
