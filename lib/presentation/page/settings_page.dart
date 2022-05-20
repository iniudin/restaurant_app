import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/presentation/bloc/setting/notification_cubit.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    Future.microtask(
      () => context.read<NotificationCubit>().getDailyNotification(),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SwitchListTile(
          title: const Text("Notifikasi"),
          subtitle: const Text(
              "Akan tampil 1 menit setelah diaktifkan dan pada pukul 11 setiap harinya."),
          onChanged: (value) =>
              context.read<NotificationCubit>().setDailyNotification(value),
          value: context.watch<NotificationCubit>().state,
        ),
      ],
    );
  }
}
