import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:milestory_web/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:milestory_web/features/creator/presentaton/map_bloc/map_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get_it/get_it.dart';
import 'package:milestory_web/injection.dart' as di;

import 'core/router/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => GetIt.I<AuthBloc>()),
          BlocProvider(create: (context) => GetIt.I<MapBloc>()),
        ],
        child: Builder(builder: (context) {
          return MaterialApp.router(
            routerConfig: AppRouter(context: context).router,
            debugShowCheckedModeBanner: false,
          );
        }),
      );
    });
  }
}
