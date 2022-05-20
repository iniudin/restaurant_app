import 'package:bloc/bloc.dart';
import 'package:restaurant_app/data/service/notification_service.dart';
import 'package:restaurant_app/data/service/shared_preference_service.dart';

class NotificationCubit extends Cubit<bool> {
  final SharedPreferenceService preferenceService;
  final NotificationService notificationService;
  NotificationCubit({
    required this.preferenceService,
    required this.notificationService,
  }) : super(false);

  void setDailyNotification(bool value) async {
    preferenceService.setDailyNotification(value);

    if (value) {
      notificationService.showNotification();
    } else {
      notificationService.cancelAllNotification();
    }

    emit(value);
  }

  Future<void> getDailyNotification() async {
    final value = await preferenceService.isDailyNotification;
    emit(value);
  }
}
