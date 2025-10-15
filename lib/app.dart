import 'package:Safeplace/src/blocs/auth_cubic.dart';
import 'package:flutter/material.dart';
import 'src/core/theme.dart';
import 'src/blocs/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/ui/screens/login_screen.dart';
import 'src/ui/screens/home_screen.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()..checkAuth()),
// other cubits
      ],
      child: MaterialApp(
        title: 'Safespace',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        home: const EntryPoint(),
      ),
    );
  }
}


class EntryPoint extends StatelessWidget {
  const EntryPoint({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) return const HomeScreen();
        if (state is Unauthenticated) return const LoginScreen();
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}