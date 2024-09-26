import 'package:flashnews/screen/splash/widgets/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final bool showButton;
  final bool showArrow;

  const SplashPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    this.showButton = false,
    this.showArrow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.65,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                ),
              ),
            ),
            if (showButton) ...[
              const SizedBox(height: 40),
              const AnimatedButton(),
            ],
          ],
        ),
        if (showArrow)
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Center(
              child: const Icon(
                Icons.arrow_forward,
                size: 32,
                color: Colors.grey,
              )
                  .animate()
                  .scale(duration: 500.ms)
                  .fadeIn(duration: 500.ms)
                  .moveX(
                    begin: -10,
                    end: 10,
                    duration: 1000.ms,
                    curve: Curves.easeInOut,
                  ),
            ),
          ),
      ],
    );
  }
}
