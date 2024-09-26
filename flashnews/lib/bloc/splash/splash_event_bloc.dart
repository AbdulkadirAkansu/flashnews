import 'package:equatable/equatable.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object> get props => [];
}

class CacheImages extends SplashEvent {}

class NavigateToNextScreen extends SplashEvent {}

class CheckFirstLaunch extends SplashEvent {}
