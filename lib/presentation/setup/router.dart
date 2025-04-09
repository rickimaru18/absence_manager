import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../pages/home/home_page.dart';
import 'routes.dart';

final GoRouter router = GoRouter(
  navigatorKey: rootNavigatorKey,
  routes: <RouteBase>[
    GoRoute(
      path: Routes.home.path,
      builder: (_, __) => BlocProvider<HomePageVm>(
        create: (_) => HomePageVm(GetIt.I()),
        child: const HomePage(),
      ),
    ),
  ],
);
