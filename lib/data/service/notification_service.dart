import 'dart:convert';
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/data/model/restaurant_model.dart';
import 'package:restaurant_app/data/service/api_service.dart';
import 'package:restaurant_app/domain/entity/restaurant.dart';
import 'package:restaurant_app/utils/datetime/datetime_helper.dart';
import 'package:restaurant_app/utils/navigation/navigation_helper.dart';
import 'package:restaurant_app/utils/route/route_helper.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const initialSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const initialSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initialSettings = const InitializationSettings(
      android: initialSettingsAndroid,
      iOS: initialSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initialSettings,
      onSelectNotification: (String? payload) async {
        Map<String, dynamic> json = jsonDecode(payload ?? '');
        RestaurantModel restaurantModel = RestaurantModel.fromJson(json);

        NavigationHelper.intentWithData(
          detailRoute,
          Restaurant(
              id: restaurantModel.id,
              name: restaurantModel.name,
              description: restaurantModel.description,
              pictureId: restaurantModel.pictureId,
              city: restaurantModel.city,
              rating: restaurantModel.rating),
        );
      },
    );
  }

  void cancelAllNotification() {
    flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> showNotification() async {
    var randomIdMessage = Random().nextInt(100);

    var restaurantList = await ApiService().getRestaurantList();
    var randomIndex = Random().nextInt(restaurantList.length);
    var randomRestaurant = restaurantList[randomIndex];

    var _channelId = "1";
    var _channelName = "Restaurant! App";
    var _channelDescription = "Recommendation! App";
    var notificationTitle = "Rekomendasi restorant untukmu!";
    var notificationBody =
        "${randomRestaurant.name} - ${randomRestaurant.city}";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: const DefaultStyleInformation(true, true),
    );

    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
    var notificationDetails = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      randomIdMessage,
      notificationTitle,
      notificationBody,
      DateTimeHelper.scheduleDaily(const Time(11, 00)),
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      payload: jsonEncode(randomRestaurant),
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
