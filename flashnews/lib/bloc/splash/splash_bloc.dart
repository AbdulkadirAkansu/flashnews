import 'package:flashnews/bloc/splash/splash_event_bloc.dart';
import 'package:flashnews/bloc/splash/splash_state_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:shared_preferences/shared_preferences.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<CacheImages>(_onCacheImages);
    on<NavigateToNextScreen>(_onNavigateToNextScreen);
    on<CheckFirstLaunch>(_onCheckFirstLaunch);
  }

  Future<void> _onCacheImages(CacheImages event, Emitter<SplashState> emit) async {
    emit(SplashLoading());
    try {
      await Future.delayed(const Duration(seconds: 2)); // Simulate caching
      emit(SplashLoaded());
    } catch (e) {
      emit(SplashError(e.toString()));
    }
  }

  Future<void> _onCheckFirstLaunch(CheckFirstLaunch event, Emitter<SplashState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    if (isFirstLaunch) {
      emit(SplashNavigateToSplashView());
    } else {
      emit(SplashNavigateToHome());
    }
  }

  Future<void> _onNavigateToNextScreen(NavigateToNextScreen event, Emitter<SplashState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstLaunch', false);
    emit(SplashNavigateToHome());
  }
}
