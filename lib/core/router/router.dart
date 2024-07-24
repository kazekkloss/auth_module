import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:milestory_web/core/router/route_constants.dart';
import 'package:milestory_web/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:milestory_web/features/auth/presentation/auth_page.dart';
import 'package:milestory_web/features/home.dart/home.dart';

import 'stream_bloc.dart';

class AppRouter {
  final BuildContext context;
  AppRouter({required this.context});
  final _rootNavigatorKey = GlobalKey<NavigatorState>();
  late AuthStatus previousStatus = AuthStatus.unknown;

  GoRouter _router() => GoRouter(
          //debugLogDiagnostics: true,
          navigatorKey: _rootNavigatorKey,
          redirect: (context, state) {
            var authState = context.read<AuthBloc>().state;
            switch (authState.status) {
              case AuthStatus.unknown:
                return state.namedLocation(RouteConstants.auth);
              case AuthStatus.unauthenticated:
                return state.namedLocation(RouteConstants.auth);
              case AuthStatus.authenticated:
                if (previousStatus != authState.status) {
                  previousStatus = authState.status;
                  return state.namedLocation(RouteConstants.home);
                } else {
                  return null;
                }
            }
          },
          refreshListenable: RouterRefreshBloc<AuthBloc, AuthState>(BlocProvider.of<AuthBloc>(context, listen: false)),
          routes: [
            GoRoute(parentNavigatorKey: _rootNavigatorKey, name: RouteConstants.auth, path: '/auth', builder: (context, state) => const AuthPage()),
            GoRoute(parentNavigatorKey: _rootNavigatorKey, name: RouteConstants.home, path: '/home', builder: (context, state) => const HomePage()),
          ]);

  GoRouter get router => _router();
}
