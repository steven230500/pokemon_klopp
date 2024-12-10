import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_api/services/api_service.dart';
import 'package:pokemon_api/services/dio_client.dart';
import 'package:pokemon_klopp/presentation/home/bloc/home_bloc.dart';
import 'package:pokemon_klopp/presentation/home/bloc/home_event.dart';
import 'package:pokemon_klopp/presentation/splash/page.dart';
import 'package:pokemon_klopp/presentation/home/page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dioClient = DioClient();
    final apiService = ApiService(dioClient: dioClient);

    return BlocProvider(
      create: (_) => HomeBloc(apiService: apiService)..add(const LoadPokemonList()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => const SplashScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
        },
      ),
    );
  }
}
