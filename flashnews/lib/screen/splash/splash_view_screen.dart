import 'package:flashnews/bloc/splash/splash_bloc.dart';
import 'package:flashnews/bloc/splash/splash_state_bloc.dart';
import 'package:flashnews/screen/home/home_screen.dart';
import 'package:flashnews/screen/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashNavigateToHome) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else if (state is SplashError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: PageView(
          children: const [
            SplashPage(
              imagePath: 'assets/splashpic.jpg',
              title: 'Welcome to FlashNews',
              subtitle: 'Experience FlashNews, the fastest and most complete news source app.',
              showArrow: true,
            ),
            SplashPage(
              imagePath: 'assets/splashpic2.jpg',
              title: 'Stay Informed',
              subtitle: 'Get the latest news updates from around the world in real-time.',
              showArrow: true,
            ),
            SplashPage(
              imagePath: 'assets/splashpic3.jpg',
              title: 'Personalized News',
              subtitle: 'Customize your news feed according to your interests and preferences.',
              showButton: true,
            ),
          ],
        ),
      ),
    );
  }
}
