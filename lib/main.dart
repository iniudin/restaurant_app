import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/presentation/bloc/detail/detail_bloc.dart';
import 'package:restaurant_app/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:restaurant_app/presentation/bloc/home/home_bloc.dart';
import 'package:restaurant_app/presentation/bloc/home/home_index_cubit.dart';
import 'package:restaurant_app/presentation/bloc/search/search_bloc.dart';
import 'package:restaurant_app/presentation/bloc/setting/notification_cubit.dart';
import 'package:restaurant_app/utils/navigation/navigation_helper.dart';
import 'package:restaurant_app/utils/route/route_helper.dart';
import 'package:restaurant_app/utils/route/route_observer_helper.dart';

import 'injector.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.getIt<HomeIndexCubit>()),
        BlocProvider(create: (_) => di.getIt<HomeBloc>()),
        BlocProvider(create: (_) => di.getIt<DetailBloc>()),
        BlocProvider(create: (_) => di.getIt<SearchBloc>()),
        BlocProvider(create: (_) => di.getIt<FavoriteBloc>()),
        BlocProvider(create: (_) => di.getIt<NotificationCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Restaurant! App',
        theme: ThemeData(primarySwatch: Colors.teal),
        navigatorObservers: [routeObserver],
        initialRoute: homeRoute,
        onGenerateRoute: RouteHelper.generateRoute,
        navigatorKey: NavigationHelper.navigatorKey,
      ),
    );
  }
}
