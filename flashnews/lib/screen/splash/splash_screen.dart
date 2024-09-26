import 'package:flashnews/bloc/splash/splash_bloc.dart';
import 'package:flashnews/bloc/splash/splash_event_bloc.dart';
import 'package:flashnews/bloc/splash/splash_state_bloc.dart';
import 'package:flashnews/screen/home/home_screen.dart';
import 'package:flashnews/screen/splash/splash_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(CheckFirstLaunch()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashNavigateToHome) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else if (state is SplashNavigateToSplashView) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const SplashView()),
            );
          } else if (state is SplashError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
