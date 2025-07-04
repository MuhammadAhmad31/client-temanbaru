import 'package:client/features/adopt/presentation/bloc/adopt_bloc.dart';
import 'package:client/main_navigation_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'di/di_container.dart' as di;
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/pets/presentation/bloc/pets_bloc.dart';
import 'features/auth/presentation/pages/login_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) {
            try {
              final authBloc = di.sl<AuthBloc>();
              return authBloc..add(AuthCheckStatusEvent());
            } catch (e) {
              print('❌ Error creating AuthBloc: $e');
              rethrow;
            }
          },
        ),
        BlocProvider<PetsBloc>(
          create: (context) {
            try {
              final petsBloc = di.sl<PetsBloc>();
              return petsBloc;
            } catch (e) {
              print('❌ Error creating PetsBloc: $e');
              rethrow;
            }
          },
        ),
        BlocProvider<AdoptBloc>(
          create: (context) {
            try {
              final adoptBloc = di.sl<AdoptBloc>();
              return adoptBloc;
            } catch (e) {
              print('❌ Error creating AdoptBloc: $e');
              rethrow;
            }
          },
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Bloc Best Architecture',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthInitial || state is AuthLoading) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            } else if (state is AuthAuthenticated) {
              return const MainNavigationPage();
            } else if (state is AuthUnauthenticated || state is AuthError) {
              return const LoginPage();
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
