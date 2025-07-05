import 'package:bootcamp_task/core/routing/app_routes.dart';
import 'package:bootcamp_task/core/routing/routes.dart';
import 'package:bootcamp_task/features/cart/cubit/cart_cubit.dart';
import 'package:bootcamp_task/features/home/cubit/product_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProductCubit(Dio())..getAllProducts()),
        BlocProvider(create: (_) => CartCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: Routes.splashScreen,
       onGenerateRoute:AppRoutes().generateRoute ,
    );
  }
}

