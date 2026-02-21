import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lokago/core/network/dio_client.dart';
import 'package:lokago/data/repositories/cart_repository.dart';
import 'package:lokago/data/repositories/payment_repository.dart';
import 'package:lokago/presentation/blocs/cart_bloc/cart_bloc.dart';
import 'package:lokago/presentation/blocs/cart_bloc/cart_event.dart';
import 'package:lokago/presentation/blocs/payment_bloc/payment_bloc.dart';
import 'package:lokago/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:lokago/presentation/blocs/user_bloc/user_event.dart';
import 'package:lokago/presentation/pages/auth/login_page.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/home_repository.dart';
import 'presentation/blocs/auth_bloc/auth_bloc.dart';
import 'presentation/blocs/home_bloc/home_bloc.dart';
import 'presentation/blocs/home_bloc/home_event.dart';

void main() {
  // Pastikan inisialisasi binding agar SharedPreferences aman
  WidgetsFlutterBinding.ensureInitialized();
  
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
        RepositoryProvider(create: (context) => CartRepository()), 
        RepositoryProvider(create: (context) => PaymentRepository()),
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
          BlocProvider(
            create: (context) => CartBloc(context.read<CartRepository>())..add(FetchCartItems()),
          ),
          BlocProvider(
            create: (context) => PaymentBloc(context.read<PaymentRepository>()),
          ),
        ],
        child: MaterialApp(
          title: 'LokaGo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0052CC)),
            useMaterial3: true,
          ),
          home: LoginPage(), 
        ),
      ),
    );
  }
}