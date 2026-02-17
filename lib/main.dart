import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lokago/core/network/dio_client.dart';
import 'package:lokago/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:lokago/presentation/blocs/user_bloc/user_event.dart';
import 'package:lokago/presentation/pages/main_screen.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/home_repository.dart';
import 'presentation/blocs/auth_bloc/auth_bloc.dart';
import 'presentation/blocs/home_bloc/home_bloc.dart';
import 'presentation/blocs/home_bloc/home_event.dart';

void main() {
  final dioClient = DioClient();
  final dio = dioClient.dio;

  runApp(MyApp(dio: dio));
}

class MyApp extends StatelessWidget {
  final dynamic dio;
  
  const MyApp({super.key, required this.dio});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthRepository(dio)),
        RepositoryProvider(create: (context) => HomeRepository(dio)),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(context.read<AuthRepository>()),
          ),
          BlocProvider(
            create: (context) => HomeBloc(context.read<HomeRepository>())..add(GetHomeData()),
          ),
          BlocProvider(
            create: (context) => UserBloc(context.read<AuthRepository>())..add(GetUserProfile()),
),
        ],
        child: MaterialApp(
          title: 'LokaGo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0052CC)),
            useMaterial3: true,
          ),
          home: MainScreen(), 
        ),
      ),
    );
  }
}