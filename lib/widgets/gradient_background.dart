import 'dart:ui';

import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Positioned.fill(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff4497ac),
                  Color(0xff7595a7),
                  Color(0xff38718c)
                ],
                stops: [0.25, 0.5, 0.87],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: -360,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
            child: Container(
              width: 560,
              height: 560,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Color(0x6CCE74B5),
                      Color(0x00CE74B5),
                    ],
                    stops: [0.5, 1],
                    center: Alignment.center,
                  )),
            ),
          ),
        ),
        Positioned(
          top: -240,
          right: -280,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
            child: Container(
              width: 600,
              height: 600,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [Color(0xD68CBBA9), Color(0x008CBBA9)],
                    stops: [0.5, 1],
                    center: Alignment.center,
                  )),
            ),
          ),
        ),
        Positioned(
          top: 120,
          right: -480,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
            child: Container(
              width: 600,
              height: 600,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [Color(0xFF8CBBA9), Color(0x008CBBA9)],
                    stops: [0.5, 1],
                    center: Alignment.center,
                  )),
            ),
          ),
        ),
        Positioned(
          top: -80,
          right: -400,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
            child: Container(
              width: 500,
              height: 500,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [Color(0x66FFFFFF), Color(0x00ffffff)],
                    stops: [0.5, 1],
                    center: Alignment.center,
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
