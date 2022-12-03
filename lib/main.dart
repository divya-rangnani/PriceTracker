import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_tracker/consts/app_const.dart';
import 'package:price_tracker/feature/home/bloc/active_symbol/active_symbol_cubit.dart';
import 'package:price_tracker/feature/home/bloc/tick_price/tick_price_cubit.dart';
import 'package:price_tracker/feature/home/ui/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ActiveSymbolCubit()),
        BlocProvider(create: (context) => TickPriceCubit()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppConst.appTitle,
        home: HomeScreen(),
      ),
    );
  }
}
